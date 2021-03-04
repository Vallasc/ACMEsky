Write-Host "RUN ALL CONTAINERS"
Set-Location .\src\BankService
.\container.ps1
Set-Location ..\GeographicalDistanceService
.\container.ps1
Set-Location ..\RentService
.\container.ps1
Write-Host "ALL CONTAINERS ARE RUNNING :)"
Set-Location ..\..