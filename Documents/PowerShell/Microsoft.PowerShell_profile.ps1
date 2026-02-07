# Load PowerShell dotfiles from .dotfiles/pwsh/
$dotfilesRoot = Split-Path -Parent (Split-Path -Parent $PROFILE)
$initScript = Join-Path $dotfilesRoot ".dotfiles" "pwsh" "init.ps1"

if (Test-Path $initScript) {
    . $initScript
} else {
    Write-Warning "Dotfiles initialization script not found at: $initScript"
}
