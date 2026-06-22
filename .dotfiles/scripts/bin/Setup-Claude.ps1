Write-Host "Logging into Claude..." -ForegroundColor Cyan
claude auth login
if ($LASTEXITCODE -ne 0) {
    Write-Error "Claude login failed."
    exit 1
}

$target = "C:\Users\swilson2\.agents\skills"
$link = Join-Path $HOME ".claude\skills"

if (Test-Path $link) {
    $item = Get-Item $link -Force
    if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
        Write-Host "Skills symlink already exists: $link -> $($item.Target)" -ForegroundColor Yellow
        exit 0
    }
    Write-Error "Path $link exists but is not a symlink. Remove it manually before re-running."
    exit 1
}

if (-not (Test-Path $target)) {
    New-Item -ItemType Directory -Path $target -Force | Out-Null
    Write-Host "Created target directory: $target" -ForegroundColor Gray
}

New-Item -ItemType Junction -Path $link -Target $target | Out-Null
Write-Host "Created junction: $link -> $target" -ForegroundColor Green
