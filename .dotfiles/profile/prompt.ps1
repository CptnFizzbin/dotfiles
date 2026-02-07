# Custom prompt function
function prompt {
    # Get current username and computer name
    $userName = $env:USERNAME
    $computerName = $env:COMPUTERNAME

    # Get current directory
    $currentPath = Get-Location

    # Get Node.js version
    $nodeVersion = ""
    if (Get-Command node -ErrorAction SilentlyContinue) {
        try {
            $nodeVersion = & node --version 2>$null
            if ($LASTEXITCODE -eq 0) {
                $nodeVersion = $nodeVersion.TrimStart('v')
            } else {
                $nodeVersion = ""
            }
        } catch {
            $nodeVersion = ""
        }
    }

    # Get git branch if in a git repository
    $gitBranch = ""
    if (Get-Command git -ErrorAction SilentlyContinue) {
        try {
            $gitBranch = & git rev-parse --abbrev-ref HEAD 2>$null
            if ($LASTEXITCODE -eq 0) {
                $gitBranch = " ‹$gitBranch›"
            } else {
                $gitBranch = ""
            }
        } catch {
            $gitBranch = ""
        }
    }

    Write-Host "╭─" -ForegroundColor White -NoNewline
    Write-Host "$userName" -ForegroundColor Green -NoNewline
    Write-Host "@" -ForegroundColor White -NoNewline
    Write-Host "$computerName" -ForegroundColor Cyan -NoNewline
    Write-Host " [Windows]" -ForegroundColor White -NoNewline
    if ($nodeVersion) {
        Write-Host " ‹$nodeVersion›" -ForegroundColor Green
    } else {
        Write-Host ""
    }

    # Build the second line: ├ /path ‹git branch›
    Write-Host "├ " -ForegroundColor White -NoNewline
    Write-Host "$currentPath" -ForegroundColor Blue -NoNewline
    if ($gitBranch) {
        Write-Host "$gitBranch" -ForegroundColor Cyan
    } else {
        Write-Host ""
    }

    # Build the third line: ╰─➤
    Write-Host "╰─" -ForegroundColor White -NoNewline
    return "PS> "
}
