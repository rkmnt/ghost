function Check-Module {
    param ([string]$ModuleName)

    if (-not (Get-Module -ListAvailable -Name $ModuleName)) {
        Write-Host "⚠️  Module '$ModuleName' is not installed." -ForegroundColor Yellow
        Write-Host "Would you like to install '$ModuleName'? (Y/N)" -ForegroundColor Magenta
        $key = [Console]::ReadKey().Key

        if ($key -eq "Y") {
            Write-Host "`n📥 Installing '$ModuleName'..." -ForegroundColor Cyan
            Install-Module -Name $ModuleName -Force -Scope CurrentUser -ErrorAction Stop
            Import-Module -Name $ModuleName -Force
            Write-Host "✅ Installed '$ModuleName'!" -ForegroundColor Green
        } else {
            Write-Host "`n❌ Module is missing. Exiting!" -ForegroundColor Red
            exit
        }
    } else {
        Import-Module -Name $ModuleName -Force
        Write-Host "✅ Module '$ModuleName' is ready!" -ForegroundColor Green
    }
}
Export-ModuleMember -Function Check-Module
