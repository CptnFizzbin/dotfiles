# Load PowerShell dotfiles
$dotfilesRoot = Split-Path -Parent (Split-Path -Parent $PROFILE)
$initScript = Join-Path $dotfilesRoot ".dotfiles" "init.ps1"

if (Test-Path $initScript) {
    . $initScript
} else {
    Write-Warning "Dotfiles initialization script not found at: $initScript"
}
