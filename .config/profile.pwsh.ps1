function Set-NoWindowsEnvs {
	Add-Content -Path $PROFILE -Value "`n`$env:JS = `"$env:HOME/JS`""
	Add-Content -Path $PROFILE -Value "`$env:PATH = `"$env:JS/bin:`$env:PATH`""
	Add-Content -Path $PROFILE -Value "`$env:MY_PATHS = `"$env:JS/bin/pwshModuls/privare_h.ps1;$env:JS/bin/repo.ps1`""
	Add-Content -Path $PROFILE -Value "`n. $Env:JS/bin/Custom_Functions.ps1"
	Add-Content -Path $PROFILE -Value ". $Env:JS/bin/RepoCli-Utils.ps1"
	Add-Content -Path $PROFILE -Value ". $Env:JS/bin/PS_Alias.ps1"
}

function Set-WindowsEnvs {
	Add-Content -Path $PROFILE -Value ". $Env:JS\bin\Custom_Functions.ps1"
	Add-Content -Path $PROFILE -Value ". $Env:JS\bin\RepoCli-Utils.ps1"
	Add-Content -Path $PROFILE -Value ". $Env:JS\bin\PS_Alias.ps1"
}

Write-Host "Configuring powershell..."
if (-not (Test-Path $PROFILE)) {
    New-Item $PROFILE -Type File -Force
}

Set-Content -Path $PROFILE -Value ""

Add-Content -Path $PROFILE -Value "Set-PSReadLineOption -EditMode Windows"

if (Get-Command "fnm" -ErrorAction SilentlyContinue) {
	Add-Content -Path $PROFILE -Value "`nfnm env --use-on-cd | Out-String | Invoke-Expression"
}

if (Get-Command "starship" -ErrorAction SilentlyContinue) {
	Add-Content -Path $PROFILE -Value "`nInvoke-Expression (&starship init powershell)"
}


if ($IsLinux) {
	Add-Content -Path $PROFILE -Value "`n`$env:Path = `"/home/js/.cargo/bin:`$env:Path`""
	Set-NoWindowsEnvs
}
if ($IsMacOS) {
	Set-NoWindowsEnvs
}
if ($IsWindows) {
	Set-WindowsEnvs
}