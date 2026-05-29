$dotfilesScriptsBin = Join-Path $HOME ".dotfiles" "scripts" "bin"

if (Test-Path $dotfilesScriptsBin) {
    $env:PATH = "$dotfilesScriptsBin$([System.IO.Path]::PathSeparator)$env:PATH"
}
