# Configure PSReadLine if available
if (Get-Command Set-PSReadlineKeyHandler -ErrorAction SilentlyContinue) {
    Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
}
