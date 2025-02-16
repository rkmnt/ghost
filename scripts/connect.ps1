param (
    [Parameter(Mandatory=$true)]
    [string]$UserPrincipalName
)

Write-Host "🔗 Connecting to Exchange Online as $UserPrincipalName..." -ForegroundColor Cyan
try {
    Connect-ExchangeOnline -UserPrincipalName $UserPrincipalName -ErrorAction Stop
    Write-Host "✅ Connected to Exchange Online!" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to connect: $_" -ForegroundColor Red
    exit
}

Write-Host "🔗 Connecting to Microsoft Teams..." -ForegroundColor Cyan
try {
    Connect-MicrosoftTeams -ErrorAction Stop
    Write-Host "✅ Connected to Microsoft Teams!" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to connect to Teams: $_" -ForegroundColor Red
    exit
}
