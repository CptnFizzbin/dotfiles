# Dotfiles management functions

# Helper function to swap .git and .git.dotfiles folders
function Switch-DotfilesGit {
    param(
        [Parameter(Mandatory=$true)]
        [string]$RepoRoot
    )
    
    $gitPath = Join-Path $RepoRoot ".git"
    $gitDotfilesPath = Join-Path $RepoRoot ".git.dotfiles"
    
    if (Test-Path $gitPath) {
        Rename-Item -Path $gitPath -NewName ".git.dotfiles" -Force
    }
    
    if (Test-Path $gitDotfilesPath) {
        Rename-Item -Path $gitDotfilesPath -NewName ".git" -Force
    }
}

# Helper function to ensure branch is prefixed with "windows"
function Ensure-WindowsBranchPrefix {
    param(
        [Parameter(Mandatory=$true)]
        [string]$RepoRoot
    )
    
    Push-Location $RepoRoot
    try {
        $currentBranch = git rev-parse --abbrev-ref HEAD 2>$null
        if ($currentBranch -and $currentBranch -ne "HEAD" -and -not $currentBranch.StartsWith("windows")) {
            $newBranch = "windows-$currentBranch"
            Write-Host "Renaming branch from '$currentBranch' to '$newBranch'..." -ForegroundColor Yellow
            git branch -m $newBranch
        }
    }
    finally {
        Pop-Location
    }
}

function dot-update {
    <#
    .SYNOPSIS
    Updates dotfiles by pulling with rebase from the remote repository.
    #>
    $dotfilesPath = Split-Path -Parent $PROFILE
    Push-Location $dotfilesPath
    try {
        # Navigate to the dotfiles repository root (two levels up from PowerShell directory)
        $repoRoot = Split-Path -Parent (Split-Path -Parent $dotfilesPath)
        Set-Location $repoRoot
        
        # Swap .git folders to access dotfiles repository
        Switch-DotfilesGit -RepoRoot $repoRoot
        
        try {
            # Ensure branch is prefixed with "windows"
            Ensure-WindowsBranchPrefix -RepoRoot $repoRoot
            
            Write-Host "Updating dotfiles from repository..." -ForegroundColor Cyan
            git pull --rebase
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "Dotfiles updated successfully!" -ForegroundColor Green
            } else {
                Write-Host "Failed to update dotfiles." -ForegroundColor Red
            }
        }
        finally {
            # Swap .git folders back to original state
            Switch-DotfilesGit -RepoRoot $repoRoot
        }
    }
    finally {
        Pop-Location
    }
}

function dot-commit {
    <#
    .SYNOPSIS
    Commits all changes in the dotfiles repository.
    .DESCRIPTION
    Adds all changes and commits them with the provided git commit flags.
    #>
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$CommitArgs
    )
    
    $dotfilesPath = Split-Path -Parent $PROFILE
    Push-Location $dotfilesPath
    try {
        # Navigate to the dotfiles repository root (two levels up from PowerShell directory)
        $repoRoot = Split-Path -Parent (Split-Path -Parent $dotfilesPath)
        Set-Location $repoRoot
        
        # Swap .git folders to access dotfiles repository
        Switch-DotfilesGit -RepoRoot $repoRoot
        
        try {
            # Ensure branch is prefixed with "windows"
            Ensure-WindowsBranchPrefix -RepoRoot $repoRoot
            
            Write-Host "Adding all changes..." -ForegroundColor Cyan
            git add .
            
            if ($CommitArgs) {
                Write-Host "Committing changes..." -ForegroundColor Cyan
                git commit @CommitArgs
            } else {
                Write-Host "Committing changes..." -ForegroundColor Cyan
                git commit
            }
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "Changes committed successfully!" -ForegroundColor Green
            } else {
                Write-Host "Failed to commit changes." -ForegroundColor Red
            }
        }
        finally {
            # Swap .git folders back to original state
            Switch-DotfilesGit -RepoRoot $repoRoot
        }
    }
    finally {
        Pop-Location
    }
}

function dot-push {
    <#
    .SYNOPSIS
    Pushes dotfiles changes to GitHub.
    #>
    $dotfilesPath = Split-Path -Parent $PROFILE
    Push-Location $dotfilesPath
    try {
        # Navigate to the dotfiles repository root (two levels up from PowerShell directory)
        $repoRoot = Split-Path -Parent (Split-Path -Parent $dotfilesPath)
        Set-Location $repoRoot
        
        # Swap .git folders to access dotfiles repository
        Switch-DotfilesGit -RepoRoot $repoRoot
        
        try {
            # Ensure branch is prefixed with "windows"
            Ensure-WindowsBranchPrefix -RepoRoot $repoRoot
            
            Write-Host "Pushing changes to GitHub..." -ForegroundColor Cyan
            git push
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "Changes pushed successfully!" -ForegroundColor Green
            } else {
                Write-Host "Failed to push changes." -ForegroundColor Red
            }
        }
        finally {
            # Swap .git folders back to original state
            Switch-DotfilesGit -RepoRoot $repoRoot
        }
    }
    finally {
        Pop-Location
    }
}
