#!/bin/bash

setup_git() {
	git config --global user.name "JohnGolgota"
	git config --global user.email "js684new@gmail.com"
}

# nodejs
setup_nodejs() {
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
	nvm install --lts
	# install pnpm
	corepack enable
	corepack prepare pnpm@latest --activate
}

# neovim
setup_nvim() {
	packer(){
		git clone --depth 1 https://github.com/wbthomason/packer.nvim\
			~/.local/share/nvim/site/pack/packer/start/packer.nvim
	}
	personal(){
		git clone --depth 1 https://github.com/JohnGolgota/nvim-config.git\
			~/.config/nvim
	}
	personal
	# git clone https://github.com/github/copilot.vim.git \
		# ~/.config/nvim/pack/github/start/copilot.vim
	# :Copilot setup
}

use_vscode() {
	code-insiders.cmd
	code.cmd
}

setup_bashpersonal() {
	#
	touch ~/.bash_aliases
	echo "alias c=code-insiders" >> ~/.bash_aliases
	echo "alias x=nvim" >> ~/.bash_aliases
	echo "alias z=tmux" >> ~/.bash_aliases
}

adivinar() {
	echo "Adivina un numero entre 1 y 10"
}