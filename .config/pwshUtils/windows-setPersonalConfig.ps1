function  WingetInstallation {
	Install-Module -Name Microsoft.WinGet.Client
}
function ScoopInstallation {
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	# Invoke-RestMethod get.scoop.sh | Invoke-Expression
	Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
	# You can use proxies if you have network trouble in accessing GitHub, e.g.
	# Invoke-RestMethod get.scoop.sh -Proxy 'http://<ip:port>' | Invoke-Expression
}
function SetFirst {
	# installation
	winget install --id Git.Git -e --source winget
	# config
	git config --global user.name "JohnGolgota"
	git config --global user.email "js684new@gmail.com"

	# primary repostory
	git clone https://github.com/JohnGolgota /JS.git $env:JS

	# winget setup
	. $env:JS/.config/winget.list.ps1
}

function SetFirstConfig {
	github $env:JS
	code $env:JS/.config/config.code-workspace
	code-insiders $env:JS/.config/config.code-workspace
	nvim $env:JS/.config/config.nvim.vim
	# nvim Copilot https://github.com/github/copilot.vim
	git clone https://github.com/github/copilot.vim.git `
		$HOME/AppData/Local/nvim/pack/github/start/copilot.vim
	# :Copilot setup
}
function SetSecond {
	pwsh $env:JS/.config/config.pwsh.ps1
	wt
	# nvm https://github.com/coreybutler/nvm-windows
	nvm install --lts
	# pnpm https://pnpm.io/es/installation
	# Invoke-WebRequest https://get.pnpm.io/install.ps1 -useb | Invoke-Expression
	corepack enable `
		corepack prepare pnpm@latest --activate
}
function setupwsl {
	function setupDebian {
		$lowercaseJS = $env:JS.ToLower()
		$caracterquejode = ":"
		$caracterquepongo = "/"
		$lowercaseJS = $lowercaseJS.Replace($caracterquejode, $caracterquepongo)
		bash "/mnt/$lowercaseJS/.config/config.bash.sh"
	}
	# WSL2 https://docs.microsoft.com/en-us/windows/wsl/install-win10
	wsl --install -d Debian
	wsl --set-default-version 2

	setupDebian
}
