---
name: changeset
description: Create changeset files for monorepo packages managed by @changesets/cli. Generates correctly-formatted .changeset/*.md files with the right package names and bump types. Use when user wants to add a changeset, record a version bump, document a change for release, or says "create a changeset", "add a changeset", "write a changeset".
---

# Changeset

A changeset is a `.changeset/<slug>.md` file that declares which packages are
bumped and why. Running `yarn changeset version` (or `npx changeset version`)
consumes these files to apply bumps and update CHANGELOGs.

## Quick start

Create `.changeset/<descriptive-slug>.md`:

```md
---
"@scope/package-a": minor
"@scope/package-b": patch
---

Added support for X in package-a and updated package-b to handle the new
response shape.
```

## Workflow

1. **Identify affected packages** — ask the user which packages changed, or
   infer from the code changes described.
2. **Find package names** — read `package.json` in each affected package
   directory to get the exact `"name"` field. Use the workspace listing in
   `package.json` or the `packages/` directory to discover them.
3. **Choose bump types** — see [Bump Type Guide](#bump-type-guide) below.
4. **Write a description** — one or more sentences summarizing the user-visible
   change. This becomes the CHANGELOG entry.
5. **Choose a filename slug** — use a short kebab-case phrase that describes the
   change (e.g. `add-pkce-support`, `fix-token-expiry`). Must be unique in
   `.changeset/`.
6. **Create the file** at `.changeset/<slug>.md`.

## Bump Type Guide

| Type    | When to use                                      |
|---------|--------------------------------------------------|
| `patch` | Bug fix, internal refactor, docs — no API change |
| `minor` | New feature, backwards-compatible API addition   |
| `major` | Breaking change — callers must update            |

When in doubt: if existing callers must change their code → `major`; if they
gain new capability without changing anything → `minor`; otherwise → `patch`.

## Private packages

Packages with `"private": true` are not published to a registry, but they
**should still receive changesets**. Their `package.json` version is used to tag
deployments — bumping it gives ops and CI a clear, human-readable marker for
what is running in each environment. Treat them identically to public packages
when deciding bump type and writing descriptions.

## Rules

- Create a **separate changeset file for each distinct feature or fix** — one
  changeset per logical change, not one per PR or session.
- Use the exact package `"name"` from its `package.json` — never guess.
- Only list packages that actually changed — omit unaffected packages.
- One changeset can cover multiple packages with different bump types.
- The description must describe the change from a **consumer's perspective** —
  avoid internal implementation details.
- Never reuse a slug that already exists in `.changeset/`.

## Applying changesets

```bash
# with yarn
yarn changeset version && yarn install

# with npm/npx
npx changeset version && npm install
```

This consumes all pending changesets, bumps `package.json` versions, and updates
`CHANGELOG.md` files.
