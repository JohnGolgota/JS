Write-Host "Configuring powershell..."
if (-not (Test-Path $PROFILE)) {
    New-Item $PROFILE -Type File -Force
}
Add-Content -Path $PROFILE -Value ". Custom_Funciones.ps1"
Add-Content -Path $PROFILE -Value "Set-CustomMain"

Add-Content -Path $PROFILE -Value "`nfnm env --use-on-cd | Out-String | Invoke-Expression"