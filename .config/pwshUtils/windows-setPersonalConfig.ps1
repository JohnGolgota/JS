function Install-My-PS-Modules {
	Write-Host "Installing winget..."
	Install-Module -Name Microsoft.WinGet.Client
	Write-Host "Instala el módulo PSSQLite desde PowerShell Gallery"
	Install-Module -Name PSSQLite
}

function ScoopInstallation {
	Write-Host "Installing scoop..."
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
	# Invoke-RestMethod get.scoop.sh | Invoke-Expression
	# You can use proxies if you have network trouble in accessing GitHub, e.g.
	# Invoke-RestMethod get.scoop.sh -Proxy 'http://<ip:port>' | Invoke-Expression
}

function setupNvim {
	git clone https://github.com/JohnGolgota/nvim-config.git "$env:LOCALAPPDATA\nvim"
}

function installAll {
	Write-Host "Installing all..."
	. $env:JS/.config/pwshUtils/winget.list.ps1
}

function SetFirstConfig {
	Write-Host "Configuring all..."
	Write-Host "Configuring github..."
	github $env:JS
	Write-Host "Configuring vscode..."
	code $env:JS/.config/config.code-workspace
	code-insiders $env:JS/.config/config.code-workspace
}

# requires admin privileges
function SetSecondConfig {
	Write-Host "Configuring pwsh..."
	pwsh $env:JS/.config/config.pwsh.ps1
	Write-Host "Configuring wt..."
	wt
	Write-Host "Configuring nvm..."
	nvm https://github.com/coreybutler/nvm-windows
	nvm install --lts
	# pnpm https://pnpm.io/es/installation
	# Invoke-WebRequest https://get.pnpm.io/install.ps1 -useb | Invoke-Expression
	Write-Host "Configuring pnpm..."
	corepack enable `
		corepack prepare pnpm@latest --activate
}

function setupwsl {
	function setupDebian {
		Write-Host "Configuring Debian..."
		$lowercaseJS = $env:JS.ToLower()
		$caracterquejode = ":"
		$caracterquepongo = "/"
		$lowercaseJS = $lowercaseJS.Replace($caracterquejode, $caracterquepongo)
		# bash "/mnt/$lowercaseJS/.config/config.bash.sh"
		bash "/mnt/$lowercaseJS/.config/config.bash.sh" $lowercaseJS
	}
	# WSL2 https://docs.microsoft.com/en-us/windows/wsl/install-win10
	Write-Host "Configuring WSL..."
	wsl --install -d Debian
	wsl --set-default-version 2

	setupDebian
}
