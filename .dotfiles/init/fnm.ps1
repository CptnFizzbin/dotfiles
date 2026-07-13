# Check if fnm is installed before initializing
if (Get-Command fnm -ErrorAction SilentlyContinue) {
    fnm env --use-on-cd --resolve-engines --shell powershell | Out-String | Invoke-Expression
} else {
    Write-Warning "fnm is not installed. Install it to enable Node.js version management."
}
