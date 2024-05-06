Write-Host "Configuring powershell..."
if (-not (Test-Path $PROFILE)) {
    New-Item $PROFILE -Type File -Force
}
Set-Content -Path $PROFILE -Value ""

Add-Content -Path $PROFILE -Value ". $Env:JS\bin\Custom_Funciones.ps1"
Add-Content -Path $PROFILE -Value ". $Env:JS\bin\RepoCli-Utils.ps1"
Add-Content -Path $PROFILE -Value ". $Env:JS\bin\PS_Alias.ps1"

Add-Content -Path $PROFILE -Value "`nfnm env --use-on-cd | Out-String | Invoke-Expression"