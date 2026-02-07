# PowerShell Dotfiles Initialization Script
# This script loads all PowerShell configuration modules

# Get the path to the dotfiles directory
# If $PROFILE is set, calculate from there; otherwise use current script location
if ($PROFILE -and (Test-Path $PROFILE)) {
    $dotfilesRoot = Split-Path -Parent (Split-Path -Parent $PROFILE)
    $dotfilesHome = Join-Path $dotfilesRoot ".dotfiles"
} else {
    # Fallback: use the directory containing this script
    $dotfilesHome = $PSScriptRoot
}

$dotfilesInit = Join-Path $dotfilesHome "init"
$dotfilesProfile = Join-Path $dotfilesHome "profile"
$dotfilesLocal = Join-Path $dotfilesHome "local"

# Load all .ps1 files from init directory
if (Test-Path $dotfilesInit) {
    Get-ChildItem -Path $dotfilesInit -Filter "*.ps1" | 
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

# Load all .ps1 files from profile directory
if (Test-Path $dotfilesProfile) {
    Get-ChildItem -Path $dotfilesProfile -Filter "*.ps1" | 
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

# Load all .ps1 files from local directory (for machine-specific customizations)
if (Test-Path $dotfilesLocal) {
    Get-ChildItem -Path $dotfilesLocal -Filter "*.ps1" | 
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

# Load local.ps1 if it exists (for additional machine-specific customizations)
$localScript = Join-Path $dotfilesHome "local.ps1"
if (Test-Path $localScript) {
    try {
        . $localScript
    }
    catch {
        Write-Warning "Failed to load local.ps1: $_"
    }
}
