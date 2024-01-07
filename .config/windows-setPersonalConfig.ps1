function  WingetInstallation {
	Install-Module -Name Microsoft.WinGet.Client
}
function ScoopInstallation {
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	Invoke-RestMethod get.scoop.sh | Invoke-Expression
	# You can use proxies if you have network trouble in accessing GitHub, e.g.
	Invoke-RestMethod get.scoop.sh -Proxy 'http://<ip:port>' | Invoke-Expression
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
wsl {
	# WSL2 https://docs.microsoft.com/en-us/windows/wsl/install-win10
	wsl --install -d Debian
	wsl --set-default-version 2
	# Dependecies wsl
	sudo apt update
	sudo apt upgrade -y
	# Dependecies avaliable with apt
	sudo apt install -y curl wget git zsh zip unzip gzip tar
	# tools
	sudo apt install -y tmux
	# Dependecies neovim
	git config --global user.name "JohnGolgota"
	git config --global user.email "js684new@gmail.com"
	node js {
		nvm & pnpm {
			# Dependecies node https://github.com/nvm-sh/nvm#installing-and-updating
			curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
			nvm install --lts
		}
		pnpm {
			# https://pnpm.io/es/installation
			curl -fsSL https://get.pnpm.io/install.sh | sh -
		}
	}
	neovim {
		# https://github.com/neovim/neovim/wiki/Installing-Neovim#linux
		curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
		chmod u+x nvim.appimage
		./nvim.appimage
		# If the ./nvim.appimage command fails, try:
		err {
			./nvim.appimage --appimage-extract
			./squashfs-root/AppRun --version

			# Optional: exposing nvim globally.
			sudo mv squashfs-root /
			sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
			nvim
		}
		copilot {
			# nvim Copilot https://github.com/github/copilot.vim
			git clone https://github.com/github/copilot.vim.git \
			~/.config/nvim/pack/github/start/copilot.vim
			{
				:Copilot setup
			}
		}
		plugvim {
			# https://github.com/junegunn/vim-plug
			Invoke-WebRequest -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
				New-Item "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
		}
	}
	code & code-insiders {
		# Configs vscode https://code.visualstudio.com/docs/remote/wsl
		code-insiders.cmd
		code.cmd
	}
	redis {
		# https://redis.io/docs/getting-started/installation/install-redis-on-windows/
		curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg

		echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list

		sudo apt-get update
		sudo apt-get install redis
	}
	rust {
		# https://www.rust-lang.org/tools/install
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	}
	profilings {
		nvim ~/.bash_aliases | nvim ~/.zshrc | nvim ~/.bashrc
		{
			alias x = nvim
			alias c = code-insiders
		}
	}
}