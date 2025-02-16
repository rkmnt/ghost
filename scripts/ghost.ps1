#!/usr/bin/env pwsh

param (
    [Alias("h")][switch]$Help,
    [Alias("u")][string]$UserPrincipalName,
    [Alias("d")][switch]$Disable,
    [Alias("e")][switch]$Enable,
    [Alias("c")][switch]$Connect
)

# Import modulů
Import-Module "$PSScriptRoot/modules/banner.psm1" -Force
Import-Module "$PSScriptRoot/modules/check.psm1" -Force

Show-Banner

Write-Host "🔍 Checking required modules..." -ForegroundColor Cyan
Check-Module -ModuleName "ExchangeOnlineManagement"
Check-Module -ModuleName "MicrosoftTeams"
Write-Host "✅ Modules checked!" -ForegroundColor Green

if ($Help) {
    Write-Host "`n📌 USAGE: ghost.ps1 -c -u admin@domain.com [-d | -e]" -ForegroundColor Yellow
    exit
}

if ($Connect -and $UserPrincipalName) {
    & "$PSScriptRoot/scripts/connect.ps1" -UserPrincipalName $UserPrincipalName
}

if ($Disable) {
    & "$PSScriptRoot/scripts/disable.ps1"
}

if ($Enable) {
    & "$PSScriptRoot/scripts/enable.ps1"
}

if ($args.Count -eq 0) {
    Write-Host "❌ No valid parameters provided. Use -h for help." -ForegroundColor Red
}
