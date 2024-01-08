#!/bin/bash

setup_git() {
	echo "git config"
	git config --global user.name "JohnGolgota"
	git config --global user.email "js684new@gmail.com"
}

# nodejs
setup_nodejs() {
	echo "nodejs config"
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
	nvm install --lts
	# install pnpm
	echo "pnpm config"
	corepack enable
	corepack prepare pnpm@latest --activate
}

# neovim
setup_nvim() {
	packer(){
		echo "packer.nvim config"
		git clone --depth 1 https://github.com/wbthomason/packer.nvim\
			~/.local/share/nvim/site/pack/packer/start/packer.nvim
	}
	personal(){
		echo "personal config"
		git clone --depth 1 https://github.com/JohnGolgota/nvim-config.git\
			~/.config/nvim
	}
	packer
	personal
	# git clone https://github.com/github/copilot.vim.git \
		# ~/.config/nvim/pack/github/start/copilot.vim
	# :Copilot setup
}

use_vscode() {
	echo "use vscode"
	code-insiders.cmd
	code.cmd
}

setup_bashpersonal() {
	echo "bash personal aliases config"
	touch ~/.bash_aliases
	echo "alias c=code-insiders" >> ~/.bash_aliases
	echo "alias x=nvim" >> ~/.bash_aliases
	echo "alias z=tmux" >> ~/.bash_aliases
}
