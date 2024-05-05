function Install-MyPSModules {
	Write-Host "Installing winget..."
	Install-Module -Name Microsoft.WinGet.Client
	Write-Host "Instala el módulo PSSQLite desde PowerShell Gallery"
	Install-Module -Name PSSQLite
}

function Install-ScoopPersonal {
	Write-Host "Installing scoop..."
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
	# Invoke-RestMethod get.scoop.sh | Invoke-Expression
	# You can use proxies if you have network trouble in accessing GitHub, e.g.
	# Invoke-RestMethod get.scoop.sh -Proxy 'http://<ip:port>' | Invoke-Expression
}

function Set-NvimPersonalConfig {
	git clone https://github.com/JohnGolgota/nvim-config.git "$env:LOCALAPPDATA\nvim"
}

function Install-WingetAll {
	Write-Host "Installing all..."
	. $env:JS/.config/pwshUtils/winget.list.ps1
}

# requires admin privileges
function Set-SecondConfig {
	Write-Host "Configuring pwsh profile..."
	pwsh $env:JS\.config\profile.pwsh.ps1
	. $PROFILE
}

function Set-PersonalSetupWSL {
	function setupDebian {
		Write-Host "Configuring Debian..."
		$lowercaseJS = $env:JS.ToLower()
		$caracter_que_jode = ":"
		$caracter_que_pongo = "/"
		$lowercaseJS = $lowercaseJS.Replace($caracter_que_jode, $caracter_que_pongo)
		# bash "/mnt/$lowercaseJS/.config/config.bash.sh"
		bash "/mnt/$lowercaseJS/.config/config.bash.sh" $lowercaseJS
	}
	# WSL2 https://docs.microsoft.com/en-us/windows/wsl/install-win10
	Write-Host "Configuring WSL..."
	wsl --install -d Debian
	wsl --set-default-version 2

	setupDebian
}

function Set-fnmPersonalSetup {
	Import-Module -Name PSSQLite
	$query = 'SELECT * FROM Applications WHERE "source" = 7 AND i_use_that = 1'
	$AplicationsList = Invoke-SqliteQuery -DataSource ".\.data\main.db" -Query $query
	if ($AplicationsList) {
		$AplicationsList | ForEach-Object {
			Write-Host "fnm install $($_.id)"
			# fnm install $_.id
		}
	}
	# fnm env --corepack-enabled
	# corepack enable pnpm
	# corepack use pnpm@latest
}
