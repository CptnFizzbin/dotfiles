# Check if zoxide is installed before initializing
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })
} else {
    Write-Warning "zoxide is not installed. Install it to enable smart directory navigation."
}
