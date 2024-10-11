function Set-NoWindowsEnvs
{
	$Paths = @(
		"${HOME}/.local/share/bob/nvim-bin",
		"$Env:JS/bin"
	)
	$NewPath = $Paths -join ':'

	Add-Content -Path $PROFILE -Value "`n`$Env:JS = `"$Env:HOME/JS`""
	Add-Content -Path $PROFILE -Value "`$Env:PATH = `"${NewPath}:`$Env:PATH`""
	Add-Content -Path $PROFILE -Value "`$Env:MY_PATHS = `"$Env:JS/private_h.ps1;$Env:JS/bin/repo.ps1`""

	Add-Content -Path $PROFILE -Value "`n. $Env:JS/bin/Custom_Functions.ps1"
	Add-Content -Path $PROFILE -Value ". $Env:JS/bin/RepoCli-Utils.ps1"
	Add-Content -Path $PROFILE -Value ". $Env:JS/bin/PS_Alias.ps1"
}

function Set-WindowsEnvs
{
	Add-Content -Path $PROFILE -Value ". $Env:JS\bin\Custom_Functions.ps1"
	Add-Content -Path $PROFILE -Value ". $Env:JS\bin\RepoCli-Utils.ps1"
	Add-Content -Path $PROFILE -Value ". $Env:JS\bin\PS_Alias.ps1"
}

Write-Host "Configuring powershell..."
if (-not (Test-Path $PROFILE))
{
	New-Item $PROFILE -Type File -Force
}

Set-Content -Path $PROFILE -Value ""

Add-Content -Path $PROFILE -Value "Set-PSReadLineOption -EditMode Windows"

if ($IsLinux)
{
	$Paths = @(
		"${HOME}/.cargo/bin"
	)
	$NewPath = $Paths -join ':'
	Add-Content -Path $PROFILE -Value "`n`$Env:PATH = `"${NewPath}:`$Env:PATH`""
	Set-NoWindowsEnvs
}
if ($IsMacOS)
{
	$Paths = @(
		"/opt/homebrew/opt/openjdk/bin",
		"/opt/homebrew/bin",
		"/opt/homebrew/sbin",
		"/Applications/Docker.app/Contents/Resources/bin",
		"${HOME}/.local/share/pnpm",
		"${HOME}/.bun/bin",
		"${HOME}/.nix-profile/bin",
		"/nix/var/nix/profiles/default/bin",
		"${HOME}/asd/bin"
		"${HOME}/.cargo/bin"
	)
	$NewPath = $Paths -join ':'
	Add-Content -Path $PROFILE -Value "`n`$Env:PATH = `"${NewPath}:`$Env:PATH`""
	Set-NoWindowsEnvs
}
if ($IsWindows)
{
	Set-WindowsEnvs
}

if (Get-Command "fnm" -ErrorAction SilentlyContinue)
{
	Add-Content -Path $PROFILE -Value "`nfnm env --use-on-cd | Out-String | Invoke-Expression"
}

if (Get-Command "starship" -ErrorAction SilentlyContinue)
{
	Add-Content -Path $PROFILE -Value "`nInvoke-Expression (&starship init powershell)"
}

if (Get-Command "zoxide" -ErrorAction SilentlyContinue)
{
	Add-Content -Path $PROFILE -Value "`nInvoke-Expression (& { (zoxide init powershell | Out-String) })"
}
