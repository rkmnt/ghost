function Show-Banner {
    Write-Host ""
    Write-Host "   ██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗" -ForegroundColor Cyan
    Write-Host "  ██╔════╝ ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝" -ForegroundColor Cyan
    Write-Host "  ██║  ███╗███████║██║   ██║███████╗   ██║   " -ForegroundColor Cyan
    Write-Host "  ██║   ██║██╔══██║██║   ██║╚════██║   ██║   " -ForegroundColor Cyan
    Write-Host "  ╚██████╔╝██║  ██║╚██████╔╝███████║   ██║   " -ForegroundColor Cyan
    Write-Host "   ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   " -ForegroundColor Cyan
    Write-Host "         [ by rkmnt ] " -ForegroundColor Yellow
}
Export-ModuleMember -Function Show-Banner
