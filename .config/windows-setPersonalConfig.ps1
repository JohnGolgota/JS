winget {
	installation {
		Install-Module -Name Microsoft.WinGet.Client
	}
}
scoop {
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	Invoke-RestMethod get.scoop.sh | Invoke-Expression
	# You can use proxies if you have network trouble in accessing GitHub, e.g.
	Invoke-RestMethod get.scoop.sh -Proxy 'http://<ip:port>' | Invoke-Expression
}
git {
	installation {
		winget install --id Git.Git -e --source winget
	}
	config {
		git config --global user.name "JohnGolgota"
		git config --global user.email "js684new@gmail.com"
	}
	primary repostory {
		git clone https://github.com/JohnGolgota/tru-01.git $HOME/tru-01
		git clone https://github.com/JohnGolgota/JS.git $env:JS
	}
	winget {
		import {
			winget import $HOME/tru-01/.configuration/winget.json --ignore-unavailable --no-upgrade
		}
	}
	return $true
}
github {
	primary repostory {
		github $HOME/tru-01
		github $env:JS
	}
	return $true
}
code & code-insiders {
	initial open {
		code $HOME/tru-01/.configuration/config.code-workspace
		code-insiders $HOME/tru-01/.configuration/config.code-workspace
	}
	return $true
}
pwsh {
	# https://learn.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.3
	installation {
		winget install --id Microsoft.PowerShell -e --source winget
	}
	config {
		pwsh $HOME/tru-01/.configuration/config.pwsh.ps1
	}
	profile {
		code-insiders.cmd $PROFILE
		{
			. Custom_Funciones.ps1
			Set-CustomMain
		}
	}
}
wt {
	installation {
		winget install --id Microsoft.WindowsTerminal -e --source winget
	}
	config {
		wt -p "Windows PowerShell" -d $HOME/tru-01/.configuration/config.wt.json
	}
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
node {
	nvm {
		# nvm https://github.com/coreybutler/nvm-windows
		nvm install --lts
	}
	pnpm {
		# pnpm https://pnpm.io/es/installation
		Start-Process pwsh -Verb RunAs {
			corepack enable
			corepack prepare pnpm@latest --activate
		}
		# Invoke-WebRequest https://get.pnpm.io/install.ps1 -useb | Invoke-Expression
	}
}
neovim {
	installation {
		scoop install neovim | winget install --id Neovim.Neovim -e --source winget
	}
	config {
		nvim $HOME/tru-01/.configuration/config.nvim.vim
	}
	copilot {
		# nvim Copilot https://github.com/github/copilot.vim
		git clone https://github.com/github/copilot.vim.git `
			$HOME/AppData/Local/nvim/pack/github/start/copilot.vim
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
Microsoft.VisualStudio {
	Community {
		return $true
	}
	BuildTools {
		return $true
	}
	return $true
}
Notion {
	return $true
}
Android Studio {
	return $true
}
dbeaver {
	supabase {
		# No voy a escribir eso xd
	}
	localhost {

	}
	docker {

	}
	return $false
}
Docker {
	mariadb {
		# https://hub.docker.com/_/mariadb
		docker run --name some-mariadb -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mariadb:tag
	}
	postgresql {
		# https://hub.docker.com/_/postgres
		docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres
	}
	mongodb {
		# https://hub.docker.com/_/mongo
		docker run --name some-mongo -d mongo:tag
		return $true
	}
	rust {
		# https://hub.docker.com/_/rust
		docker run -it --name my-running-app my-rust-app
		return $true
	}
	redis {
		# https://redis.io/docs/getting-started/install-stack/docker/
		# https://hub.docker.com/_/redis
		docker run --name some-redis -d redis
		return $true
	}
	return $true
}
Python {
	# https://www.python.org/downloads/
	return $false
}
rust {
	# https://www.rust-lang.org/tools/install
	return $false
}
zig {
	# https://ziglang.org/download/
	return $false
}
GoLang {
	# https://golang.org/doc/install
	return $false
}
OBSStudio {
	return $true
}
steam {
	return $true
}
insomnia {
	return $true
}
TightVNC {
	return $true
}
PowerToys {
	return $true
}
AnyDesk {
	return $true
}
redis {
	# https://redis.io/download
	return $false
}
Discord {
	return $true
}
seccond {
	Pcmanager {
		return $false
	}
	Edge {
		return $true
	}
	DevHome {
		return $true
	}
	OneDrive {
		return $true
	}
	OptionsPlus {
		# Que las fs funcionen como fs
		return $true
	}
}
