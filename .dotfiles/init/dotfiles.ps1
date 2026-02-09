# Dotfiles management functions
function Push-LocationDotfiles {
    Push-Location "~"
}

function Enable-DotfilesGit {
    $gitPath = Join-Path "~" ".git"
    $gitDotfilesPath = Join-Path "~" ".git.dotfiles"

    if (Test-Path $gitPath)
    {
        return
    }

    Rename-Item -Path $gitDotfilesPath -NewName ".git" -Force
}

function Disable-DotfilesGit {
    $gitPath = Join-Path "~" ".git"
    $gitDotfilesPath = Join-Path "~" ".git.dotfiles"

    if (Test-Path $gitDotfilesPath)
    {
        return
    }

    Rename-Item -Path $gitPath -NewName ".git.dotfiles" -Force
}

function dot-update {
    Push-LocationDotfiles

    try {
        Enable-DotfilesGit
        try {
            Write-Host "Updating dotfiles from repository..." -ForegroundColor Cyan
            git pull --rebase

            if ($LASTEXITCODE -eq 0) {
                Write-Host "Dotfiles updated successfully!" -ForegroundColor Green
            } else {
                Write-Host "Failed to update dotfiles." -ForegroundColor Red
            }
        }
        finally {
            Disable-DotfilesGit
        }
    }
    finally {
        Pop-Location
    }
}

function dot-add {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$CommitArgs
    )

    Push-LocationDotfiles

    try {
        Enable-DotfilesGit
        try {
            git add -f @CommitArgs
        }
        finally {
            Disable-DotfilesGit
        }
    }
    finally {
        Pop-Location
    }
}

function dot-status {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$CommitArgs
    )

    Push-LocationDotfiles

    try {
        Enable-DotfilesGit
        try {
            git status @CommitArgs
        }
        finally {
            Disable-DotfilesGit
        }
    }
    finally {
        Pop-Location
    }
}

function dot-commit {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$CommitArgs
    )

    Push-LocationDotfiles

    try {
        Enable-DotfilesGit
        try {
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
            Disable-DotfilesGit
        }
    }
    finally {
        Pop-Location
    }
}

function dot-push {
    Push-LocationDotfiles

    try {
        Enable-DotfilesGit
        try {
            Write-Host "Pushing changes to GitHub..." -ForegroundColor Cyan
            git push

            if ($LASTEXITCODE -eq 0) {
                Write-Host "Changes pushed successfully!" -ForegroundColor Green
            } else {
                Write-Host "Failed to push changes." -ForegroundColor Red
            }
        }
        finally {
            Disable-DotfilesGit
        }
    }
    finally {
        Pop-Location
    }
}
