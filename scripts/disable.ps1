Write-Host "🚫 Disabling all communication..." -ForegroundColor Red

try {
    New-TransportRule -Name "Block All Emails" `
        -FromScope InOrganization -SentToScope InOrganization `
        -RejectMessageReasonText "Email communication is disabled" `
        -RejectMessageEnhancedStatusCode "5.7.1" -ErrorAction Stop

    Set-CsTeamsMessagingPolicy -Identity "Global" `
        -AllowUserChat $false `
        -AllowUserEditMessage $false `
        -AllowUserDeleteMessage $false -ErrorAction Stop

    Write-Host "✅ Communication has been disabled!" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to disable communication: $_" -ForegroundColor Red
}
