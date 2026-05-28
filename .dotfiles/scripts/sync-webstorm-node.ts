/**
 * Discovers Node.js interpreters managed by FNM from both Windows and WSL,
 * then updates all WebStorm nodejs.xml configuration files.
 *
 * Existing excluded entries (e.g. the system Node install marked excluded="true")
 * are preserved per WebStorm config directory.
 */

import { execSync, execFileSync } from 'node:child_process'
import { existsSync, readdirSync, mkdirSync, writeFileSync, readFileSync } from 'node:fs'
import { join } from 'node:path'
import os from 'node:os'
import { create } from 'xmlbuilder2'
import { createTwoFilesPatch } from 'diff'
import semver from 'semver'

const HOME = os.homedir()
const APPDATA = process.env.APPDATA!

const WSL_TOOL_DISTROS = new Set([
  'podman-machine-default',
  'wsl-vpnkit',
  'rancher-desktop',
  'rancher-desktop-data',
])

interface WindowsNode {
  path: string
}

interface WslNode {
  distribution: string
  path: string
}

interface ExcludedEntry {
  path: string
}

// --- Discovery ---

function discoverWindowsNodes(): WindowsNode[] {
  const fnmDir = join(APPDATA, 'fnm', 'node-versions')
  if (!existsSync(fnmDir)) {
    console.warn(`  Windows FNM directory not found: ${fnmDir}`)
    return []
  }

  return readdirSync(fnmDir)
    .filter(d => /^v\d/.test(d))
    .flatMap(dir => {
      const exePath = join(fnmDir, dir, 'installation', 'node.exe')
      if (!existsSync(exePath)) return []
      // WebStorm uses $USER_HOME$ as a placeholder for the Windows home directory
      const normalizedPath = '$USER_HOME$' + exePath.replace(HOME, '').replace(/\\/g, '/')
      return [{ path: normalizedPath }]
    })
}

function linuxToUncPath(distribution: string, linuxPath: string): string {
  return `\\\\wsl.localhost\\${distribution}${linuxPath.replace(/\//g, '\\')}`
}

function discoverWslNodes(distribution: string): WslNode[] {
  try {
    const home = execFileSync('wsl', ['-d', distribution, '-e', 'bash', '-c', 'echo $HOME'], {
      encoding: 'utf8',
      timeout: 5000,
    }).trim()

    const fnmDir = `${home}/.local/share/fnm/node-versions`
    const uncFnmDir = linuxToUncPath(distribution, fnmDir)

    if (!existsSync(uncFnmDir)) {
      return []
    }

    const dirs = readdirSync(uncFnmDir).filter(d => /^v\d/.test(d))

    return dirs.flatMap(dir => {
      const nodePath = `${fnmDir}/${dir}/installation/bin/node`
      const uncNodePath = linuxToUncPath(distribution, nodePath)
      const found = existsSync(uncNodePath)
      if (!found) return []
      return [{ distribution, path: nodePath }]
    })
  } catch (err) {
    console.warn(`    Error scanning ${distribution}: ${err}`)
    return []
  }
}

function getWslDistributions(): string[] {
  try {
    // wsl -l -q outputs UTF-16LE on Windows
    const raw = execSync('wsl -l -q', { encoding: 'buffer', timeout: 10000 })
    return raw
      .toString('utf16le')
      .split(/\r?\n/)
      .map(d => d.trim().replace(/\0/g, ''))
      .filter(d => d.length > 0 && !WSL_TOOL_DISTROS.has(d))
  } catch {
    console.warn('  Could not enumerate WSL distributions')
    return []
  }
}

// --- XML ---

/**
 * Read excluded local-interpreter entries from an existing nodejs.xml so they
 * are preserved in the updated file (e.g. the system Node install marked
 * excluded="true" to stop WebStorm from prompting about it).
 */
function readConfiguredNodes(xmlPath: string): { windowsPaths: Set<string>; wslPaths: Set<string> } {
  const windowsPaths = new Set<string>()
  const wslPaths = new Set<string>()
  if (!existsSync(xmlPath)) return { windowsPaths, wslPaths }

  const doc = create(readFileSync(xmlPath, 'utf8'))
  doc.root().each(component => {
    // @ts-ignore
    const name: string = component.node.getAttribute?.('name')
    if (name === 'NodeJsLocalInterpreterManager') {
      component.each(child => {
        // @ts-ignore
        const path: string | null = child.node.getAttribute?.('path') ?? null
        // @ts-ignore
        const excl: string | null = child.node.getAttribute?.('excluded') ?? null
        if (path && excl !== 'true') windowsPaths.add(path)
      })
    } else if (name === 'WslNodeInterpreterManager') {
      component.each(child => {
        // @ts-ignore
        const path: string | null = child.node.getAttribute?.('path') ?? null
        if (path) wslPaths.add(path)
      })
    }
  })
  return { windowsPaths, wslPaths }
}

function versionFromPath(nodePath: string): string {
  return nodePath.match(/\/(v[\d.]+)\//)?.[1] ?? nodePath
}

function deduplicateToLatestMinor<T extends { path: string }>(nodes: T[]): T[] {
  const best = new Map<string, { node: T; ver: semver.SemVer }>()
  for (const node of nodes) {
    const ver = semver.parse(versionFromPath(node.path))
    if (!ver) continue
    const key = `${ver.major}.${ver.minor}`
    const existing = best.get(key)
    if (!existing || semver.gt(ver, existing.ver)) best.set(key, { node, ver })
  }
  return [...best.values()]
    .sort((a, b) => semver.compare(a.ver, b.ver))
    .map(g => g.node)
}

function missingNodeLines(
  windowsNodes: WindowsNode[],
  wslNodes: WslNode[],
  configured: { windowsPaths: Set<string>; wslPaths: Set<string> }
): string[] {
  const lines: string[] = []

  const missingWindows = windowsNodes.filter(n => !configured.windowsPaths.has(n.path))
  if (missingWindows.length > 0)
    lines.push(`Windows: ${missingWindows.map(n => versionFromPath(n.path)).join(', ')}`)

  const wslByDist = new Map<string, string[]>()
  for (const n of wslNodes.filter(n => !configured.wslPaths.has(n.path))) {
    const group = wslByDist.get(n.distribution) ?? []
    group.push(versionFromPath(n.path))
    wslByDist.set(n.distribution, group)
  }
  for (const [dist, versions] of wslByDist)
    lines.push(`${dist}: ${versions.join(', ')}`)

  return lines
}

function readExcludedEntries(xmlPath: string): ExcludedEntry[] {
  if (!existsSync(xmlPath)) return []

  const doc = create(readFileSync(xmlPath, 'utf8'))
  const excluded: ExcludedEntry[] = []

  doc.root().each(component => {
    // @ts-ignore - xmlbuilder2 node is a DOM Node
    if (component.node.getAttribute?.('name') !== 'NodeJsLocalInterpreterManager') return
    component.each(child => {
      // @ts-ignore
      const path: string | null = child.node.getAttribute?.('path') ?? null
      // @ts-ignore
      const excl: string | null = child.node.getAttribute?.('excluded') ?? null
      if (path && excl === 'true') excluded.push({ path })
    })
  })

  return excluded
}

function buildXml(
  windowsNodes: WindowsNode[],
  wslNodes: WslNode[],
  excluded: ExcludedEntry[]
): string {
  const doc = create({ version: '1.0' }).ele('application')

  const localMgr = doc.ele('component', { name: 'NodeJsLocalInterpreterManager' })
  for (const node of windowsNodes) {
    localMgr.ele('local-interpreter', { path: node.path })
  }
  for (const entry of excluded) {
    localMgr.ele('local-interpreter', { path: entry.path, excluded: 'true' })
  }

  const wslMgr = doc.ele('component', { name: 'WslNodeInterpreterManager' })
  for (const node of wslNodes) {
    wslMgr.ele('wsl-interpreter', { distribution: node.distribution, path: node.path })
  }

  return doc.end({ prettyPrint: true, indent: '  ' })
}

const ANSI = {
  reset:  '\x1b[0m',
  red:    '\x1b[31m',
  green:  '\x1b[32m',
  cyan:   '\x1b[36m',
  yellow: '\x1b[33m',
  dim:    '\x1b[2m',
}

function colorDiffLine(line: string): string {
  if (line.startsWith('+++') || line.startsWith('---')) return ANSI.yellow + line + ANSI.reset
  if (line.startsWith('+')) return ANSI.green  + line + ANSI.reset
  if (line.startsWith('-')) return ANSI.red    + line + ANSI.reset
  if (line.startsWith('@@'))                   return ANSI.cyan   + line + ANSI.reset
  return ANSI.dim + line + ANSI.reset
}

// Parses "WebStorm2025.1" → { name: "WebStorm", sort: 2025001 }
function parseIdeDir(dir: string): { name: string; sort: number } | null {
  const m = dir.match(/^([A-Za-z]+)(\d{4})\.(\d+)$/)
  if (!m) return null
  return { name: m[1], sort: parseInt(m[2]) * 1000 + parseInt(m[3]) }
}

function latestNPerIde(dirs: string[], n: number): string[] {
  const groups = new Map<string, string[]>()
  for (const dir of dirs) {
    const parsed = parseIdeDir(dir)
    if (!parsed) continue
    const group = groups.get(parsed.name) ?? []
    group.push(dir)
    groups.set(parsed.name, group)
  }
  const result: string[] = []
  for (const group of groups.values()) {
    group.sort((a, b) => (parseIdeDir(b)?.sort ?? 0) - (parseIdeDir(a)?.sort ?? 0))
    result.push(...group.slice(0, n))
  }
  return result
}

function checkConfigs(windowsNodes: WindowsNode[], wslNodes: WslNode[]): void {
  const jetbrainsDir = join(APPDATA, 'JetBrains')
  if (!existsSync(jetbrainsDir)) {
    console.warn(`JetBrains config directory not found: ${jetbrainsDir}`)
    return
  }

  const allDirs = readdirSync(jetbrainsDir, { withFileTypes: true })
    .filter(d => d.isDirectory())
    .map(d => d.name)
  const ideDirs = latestNPerIde(allDirs, 3)

  if (ideDirs.length === 0) {
    console.warn('No JetBrains config directories found.')
    return
  }

  let upToDate = 0, outOfDate = 0

  for (const ideDir of ideDirs) {
    const xmlPath = join(jetbrainsDir, ideDir, 'options', 'nodejs.xml')

    if (!existsSync(xmlPath)) continue

    const existing = readFileSync(xmlPath, 'utf8')
    const excluded = readExcludedEntries(xmlPath)
    const expected = buildXml(windowsNodes, wslNodes, excluded)
    if (existing === expected) {
      console.log(`  ${ANSI.green}✓${ANSI.reset} ${ideDir}`)
      upToDate++
    } else {
      console.log(`  ${ANSI.yellow}~${ANSI.reset} ${ideDir}  ${ANSI.dim}out of date${ANSI.reset}`)
      const lines = missingNodeLines(windowsNodes, wslNodes, readConfiguredNodes(xmlPath))
      lines.forEach(l => console.log(`      ${ANSI.dim}${l}${ANSI.reset}`))
      outOfDate++
    }
  }

  const parts = [
    upToDate  > 0 ? `${ANSI.green}${upToDate} up to date${ANSI.reset}`   : '',
    outOfDate > 0 ? `${ANSI.yellow}${outOfDate} out of date${ANSI.reset}` : '',
  ].filter(Boolean)
  console.log(`\n  ${parts.join(', ') || 'no IDEs with nodejs.xml found'}`)
}

function updateWebStormConfigs(windowsNodes: WindowsNode[], wslNodes: WslNode[], dryRun: boolean): void {
  const jetbrainsDir = join(APPDATA, 'JetBrains')
  if (!existsSync(jetbrainsDir)) {
    console.warn(`JetBrains config directory not found: ${jetbrainsDir}`)
    return
  }

  const allDirs = readdirSync(jetbrainsDir).filter(d => !!parseIdeDir(d))
  const ideDirs = latestNPerIde(allDirs, 3)
  if (ideDirs.length === 0) {
    console.warn('No JetBrains IDE config directories found.')
    return
  }

  for (const wsDir of ideDirs) {
    const optionsDir = join(jetbrainsDir, wsDir, 'options')
    const xmlPath = join(optionsDir, 'nodejs.xml')

    const excluded = readExcludedEntries(xmlPath)
    const xml = buildXml(windowsNodes, wslNodes, excluded)

    const note = excluded.length ? ` (preserved ${excluded.length} excluded)` : ''

    const existing = existsSync(xmlPath) ? readFileSync(xmlPath, 'utf8') : ''
    const changed = existing !== xml

    if (dryRun) {
      if (!changed) {
        console.log(`  [dry-run] No changes: ${xmlPath}`)
      } else {
        const patch = createTwoFilesPatch(xmlPath, xmlPath, existing, xml, 'current', 'updated')
        console.log(`  [dry-run] Would write: ${xmlPath}${note}`)
        console.log(patch.split('\n').map(colorDiffLine).join('\n'))
      }
    } else {
      if (!changed) {
        console.log(`  No changes: ${xmlPath}`)
      } else {
        mkdirSync(optionsDir, { recursive: true })
        writeFileSync(xmlPath, xml, 'utf8')
        console.log(`  Updated: ${xmlPath}${note}`)
      }
    }
  }
}

// --- Main ---

const args = process.argv.slice(2)
const DRY_RUN = args.includes('--dry-run') || args.includes('-n')
const CHECK   = args.includes('--check')

if (DRY_RUN) console.log('[dry-run] No files will be written.\n')

console.log('Discovering Windows FNM nodes...')
const windowsNodes = deduplicateToLatestMinor(discoverWindowsNodes())
windowsNodes.forEach(n => console.log(`  ${n.path}`))
if (windowsNodes.length === 0) console.log('  None found.')

console.log('\nDiscovering WSL FNM nodes...')
const distributions = getWslDistributions()
console.log(`  Distributions: ${distributions.join(', ') || 'none'}`)

const wslNodes = distributions.flatMap(d => {
  console.log(`  Scanning ${d}...`)
  const nodes = deduplicateToLatestMinor(discoverWslNodes(d))
  nodes.forEach(n => console.log(`    ${n.path}`))
  if (nodes.length === 0) console.log('    None found.')
  return nodes
})

if (CHECK) {
  console.log('\nChecking JetBrains IDE configs...')
  checkConfigs(windowsNodes, wslNodes)
} else {
  console.log('\nUpdating WebStorm configs...')
  updateWebStormConfigs(windowsNodes, wslNodes, DRY_RUN)
}

console.log('\nDone!')
