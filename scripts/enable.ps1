Write-Host "✅ Enabling all communication..." -ForegroundColor Green

try {
    Remove-TransportRule -Identity "Block All Emails" -Confirm:$false -ErrorAction Stop

    Set-CsTeamsMessagingPolicy -Identity "Global" `
        -AllowUserChat $true `
        -AllowUserEditMessage $true `
        -AllowUserDeleteMessage $true -ErrorAction Stop

    Write-Host "✅ Communication has been enabled!" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to enable communication: $_" -ForegroundColor Red
}
