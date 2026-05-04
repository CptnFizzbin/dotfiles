# Load PowerShell dotfiles
# Assume .dotfiles is at ~/.dotfiles
$initScript = Join-Path $HOME ".dotfiles" "init.ps1"

if (Test-Path $initScript) {
    . $initScript
} else {
    Write-Warning "Dotfiles initialization script not found at: $initScript"
}

# fnm (Fast Node Manager) shell integration
fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
