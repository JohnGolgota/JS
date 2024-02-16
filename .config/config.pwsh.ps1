param (
	[Parameter]
	[string]$JS = ""
)
Write-Host "Configuring powershell..."

New-Item $PROFILE -Type File -Force

if ($JS -eq "") {
	$JS = Read-Host "Enter the path to the JS folder"
	Add-Content -Path $PROFILE -Value "`$env:JS = `"$JS`""
}

Add-Content -Path $PROFILE -Value "Set-PSReadLineOption -EditMode Windows"
Add-Content -Path $PROFILE -Value ". Custom_Funciones.ps1"
Add-Content -Path $PROFILE -Value "Set-CustomMain"