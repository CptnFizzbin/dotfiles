$scriptsDir = Join-Path $PSScriptRoot ".."
$script = Join-Path $scriptsDir "utils" "sync-webstorm-node.ts"
yarn --cwd $scriptsDir vite-node $script @args
