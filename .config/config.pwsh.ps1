Write-Host "Configuring powershell..."
New-Item $PROFILE -Type File -Force
Add-Content -Path $PROFILE -Value ". Set-CustomMain.ps1"