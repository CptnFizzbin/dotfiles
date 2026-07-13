[CmdletBinding()]
param(
    [Parameter()]
    [string]$Name
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Main {
    Write-Host "Hello, $Name"
}

Main
