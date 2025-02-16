#!/usr/bin/env pwsh

param (
    [Alias("h")][switch]$Help,
    [Alias("u")][string]$UserPrincipalName,
    [Alias("d")][switch]$Disable,
    [Alias("e")][switch]$Enable,
    [Alias("c")][switch]$Connect
)

function Ensure-ModuleInstalled {
    param ([string]$ModuleName)
    if (-not (Get-Module -ListAvailable -Name $ModuleName)) {
        Write-Host "📦 Module '$ModuleName' is missing. Installing..." -ForegroundColor Yellow
        try {
            Install-Module -Name $ModuleName -Force -Scope CurrentUser -AllowClobber -ErrorAction Stop
            Write-Host "✅ Module '$ModuleName' installed successfully!" -ForegroundColor Green
        } catch {
            Write-Host "❌ Failed to install module '$ModuleName'. Please install it manually: Install-Module -Name $ModuleName -Scope CurrentUser" -ForegroundColor Red
            exit 1
        }
    }
}

Write-Host "🔍 Checking required modules..." -ForegroundColor Cyan
Ensure-ModuleInstalled -ModuleName "ExchangeOnlineManagement"
Ensure-ModuleInstalled -ModuleName "MicrosoftTeams"
Write-Host "✅ Modules checked!" -ForegroundColor Green

$modules = @("banner", "check")
foreach ($module in $modules) {
    $modulePath = "$PSScriptRoot/modules/$module.psm1"
    if (Test-Path $modulePath) {
        Import-Module $modulePath -Force -WarningAction SilentlyContinue
    } else {
        Write-Host "❌ Missing module: $modulePath" -ForegroundColor Red
        exit 1
    }
}

Show-Banner

function Show-Help {
    Write-Host "`n📌 USAGE: ghost -c -u admin@domain.com [-d | -e]" -ForegroundColor Yellow
    Write-Host "`n🛠️  Available options:" -ForegroundColor Cyan
    Write-Host "  -h                Show this help message"
    Write-Host "  -c                Connect to the service"
    Write-Host "  -u <email>        Specify the user (required with -c)"
    Write-Host "  -d                Disable something"
    Write-Host "  -e                Enable something"
    Write-Host "`n📖 Example:" -ForegroundColor Magenta
    Write-Host "  ghost -c -u admin@domain.com -e"
    exit
}

if ($Help -or (-not $Connect -and -not $Disable -and -not $Enable)) {
    Show-Help
}

if ($Connect -and (-not $UserPrincipalName)) {
    Write-Host "❌ ERROR: Missing required parameter '-u <email>' when using '-c'." -ForegroundColor Red
    Show-Help
}

if ($Connect) {
    Write-Host "🔗 Connecting user '$UserPrincipalName'..." -ForegroundColor Cyan
    & "$PSScriptRoot/scripts/connect.ps1" -UserPrincipalName $UserPrincipalName
}

if ($Disable) {
    Write-Host "🛑 Disabling..." -ForegroundColor Red
    & "$PSScriptRoot/scripts/disable.ps1"
}

if ($Enable) {
    Write-Host "✅ Enabling..." -ForegroundColor Green
    & "$PSScriptRoot/scripts/enable.ps1"
}
