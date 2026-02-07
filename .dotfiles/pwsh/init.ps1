# PowerShell Dotfiles Initialization Script
# This script loads all PowerShell configuration modules from .dotfiles/pwsh/

# Get the path to the dotfiles directory
# If $PROFILE is set, calculate from there; otherwise use current script location
if ($PROFILE -and (Test-Path $PROFILE)) {
    $dotfilesRoot = Split-Path -Parent (Split-Path -Parent $PROFILE)
    $pwshInitDir = Join-Path $dotfilesRoot ".dotfiles" "pwsh"
} else {
    # Fallback: use the directory containing this script
    $pwshInitDir = $PSScriptRoot
}

# Source all .ps1 files in the pwsh directory except init.ps1
if (Test-Path $pwshInitDir) {
    Get-ChildItem -Path $pwshInitDir -Filter "*.ps1" | 
        Where-Object { $_.Name -ne "init.ps1" } |
        Sort-Object Name |
        ForEach-Object {
            try {
                . $_.FullName
            }
            catch {
                Write-Warning "Failed to load $($_.Name): $_"
            }
        }
}
