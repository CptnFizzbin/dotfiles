# Check if zoxide is installed before initializing
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })
} else {
    Write-Warning "zoxide is not installed. Install it to enable smart directory navigation."
}

# Check if fnm is installed before initializing
if (Get-Command fnm -ErrorAction SilentlyContinue) {
    fnm env --use-on-cd --shell powershell --corepack-enabled | Out-String | Invoke-Expression
} else {
    Write-Warning "fnm is not installed. Install it to enable Node.js version management."
}
