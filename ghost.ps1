#!/usr/bin/env pwsh

param (
    [Parameter(Mandatory=$false)]
    [Alias("h")]
    [switch]$Help,

    [Parameter(Mandatory=$false)]
    [Alias("u")]
    [string]$UserPrincipalName,

    [Parameter(Mandatory=$false)]
    [Alias("d")]
    [switch]$Disable,

    [Parameter(Mandatory=$false)]
    [Alias("e")]
    [switch]$Enable,

    [Parameter(Mandatory=$false)]
    [Alias("c")]
    [switch]$Connect
)

function Show-Banner {
    Write-Host ""
    Write-Host "   ██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗" -ForegroundColor Cyan
    Write-Host "  ██╔════╝ ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝" -ForegroundColor Cyan
    Write-Host "  ██║  ███╗███████║██║   ██║███████╗   ██║   " -ForegroundColor Cyan
    Write-Host "  ██║   ██║██╔══██║██║   ██║╚════██║   ██║   " -ForegroundColor Cyan
    Write-Host "  ╚██████╔╝██║  ██║╚██████╔╝███████║   ██║   " -ForegroundColor Cyan
    Write-Host "   ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   " -ForegroundColor Cyan
    Write-Host "         [ by ht0p_ ] " -ForegroundColor Yellow
    Write-Separator
}

#
function Write-Separator {
    Write-Host "--------------------------------------------------------" -ForegroundColor DarkGray
}

function Check-Module {
    param (
        [string]$ModuleName
    )

    try {
        if (-not (Get-Module -ListAvailable -Name $ModuleName)) {
            Write-Host "⚠️  The required module '$ModuleName' is not installed." -ForegroundColor Yellow
            Write-Host "Would you like to install '$ModuleName'? (Y/N)" -ForegroundColor Magenta
            $key = [Console]::ReadKey().Key

            if ($key -eq "Y") {
                Write-Host "`n📥 Installing '$ModuleName'..." -ForegroundColor Cyan
                Install-Module -Name $ModuleName -Force -AllowClobber -Scope CurrentUser -ErrorAction Stop
                Import-Module -Name $ModuleName -Force -ErrorAction Stop
                Write-Host "✅ '$ModuleName' installed successfully!" -ForegroundColor Green
            } else {
                Write-Host "`n❌ Skipping installation of '$ModuleName'. The script may not work correctly!" -ForegroundColor Red
                exit
            }
        } else {
            Import-Module -Name $ModuleName -Force -ErrorAction Stop
            Write-Host "✅ Module '$ModuleName' is installed and ready." -ForegroundColor Green
        }
    } catch {
        Write-Host "`n❌ Failed to install or import '$ModuleName': $_" -ForegroundColor Red
        exit
    }
}


Show-Banner

Write-Host "🔍 Checking required modules..." -ForegroundColor Cyan
Check-Module -ModuleName "ExchangeOnlineManagement"
Check-Module -ModuleName "MicrosoftTeams"
Write-Separator

if ($Help) {
    Write-Separator
    Write-Host "📌 USAGE: .\script.ps1 -c -u <admin@domain.com> [-d | -e]" -ForegroundColor Yellow
    Write-Separator
    Write-Host "  -c   -Connect      Connect to Exchange Online and Microsoft Teams." -ForegroundColor Cyan
    Write-Host "  -u   -User         Specify the admin email to connect to Exchange Online and Microsoft Teams." -ForegroundColor Cyan
    Write-Host "  -d   -Disable      Disable Outlook and Teams communication for all users." -ForegroundColor Cyan
    Write-Host "  -e   -Enable       Enable Outlook and Teams communication for all users." -ForegroundColor Cyan
    Write-Host "  -h   -Help         Show this help message." -ForegroundColor Cyan
    Write-Separator
    exit
}

if ($Connect -and $UserPrincipalName) {
    Write-Host "🔗 Connecting to Exchange Online as $UserPrincipalName..." -ForegroundColor Cyan
    try {
        Connect-ExchangeOnline -UserPrincipalName $UserPrincipalName -ErrorAction Stop
    } catch {
        Write-Host "❌ Failed to connect to Exchange Online: $_" -ForegroundColor Red
        exit
    }

    Write-Host "🔗 Connecting to Microsoft Teams..." -ForegroundColor Cyan
    try {
        Connect-MicrosoftTeams -ErrorAction Stop
    } catch {
        Write-Host "❌ Failed to connect to Microsoft Teams: $_" -ForegroundColor Red
        exit
    }
}

if ($Disable) {
    Write-Separator
    Write-Host "🚫 Disabling all communication..." -ForegroundColor Red

    try {
        New-TransportRule -Name "Block All Emails" `
            -FromScope InOrganization -SentToScope InOrganization `
            -RejectMessageReasonText "E-mailová komunikace je v současné době zakázána administrátorem." `
            -RejectMessageEnhancedStatusCode "5.7.1" -ErrorAction Stop

        $policyName = "Global"
        Set-CsTeamsMessagingPolicy -Identity $policyName -AllowUserChat $false -AllowUserEditMessage $false -AllowUserDeleteMessage $false -ErrorAction Stop

        Write-Host "✅ Communication has been disabled!" -ForegroundColor Green
    } catch {
        Write-Host "❌ Failed to disable communication: $_" -ForegroundColor Red
    }
    Write-Separator
}

if ($Enable) {
    Write-Separator
    Write-Host "✅ Enabling all communication..." -ForegroundColor Green

    try {
        Remove-TransportRule -Identity "Block All Emails" -Confirm:$false -ErrorAction Stop

        $policyName = "Global"
        Set-CsTeamsMessagingPolicy -Identity $policyName -AllowUserChat $true -AllowUserEditMessage $true -AllowUserDeleteMessage $true -ErrorAction Stop

        Write-Host "✅ Communication has been enabled!" -ForegroundColor Green
    } catch {
        Write-Host "❌ Failed to enable communication: $_" -ForegroundColor Red
    }
    Write-Separator
}

if ($args.Count -eq 0) {
    Write-Separator
    Write-Host "❌ No valid parameters provided. Use -h for help." -ForegroundColor Red
    Write-Separator
}
