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
setup_nvim() {
  git clone https://github.com/github/copilot.vim.git \
    ~/.config/nvim/pack/github/start/copilot.vim
  # :Copilot setup
}
use_vscode() {
  code-insiders.cmd
  code.cmd
}
setup_bashpersonal() {
  touch ~/.bash_aliases
  echo "alias c=code-insiders" >> ~/.bash_aliases
  echo "alias x=nvim" >> ~/.bash_aliases
  echo "alias z=tmux" >> ~/.bash_aliases
}

sudo apt-get update
sudo apt-get upgrade

# Download and install
# avalible with apt-get
sudo apt-get install curl wget git zsh unzip gzip tar -y
# tools
sudo apt-get install tmux neovim -y

setup_git
setup_nodejs
setup_nvim
use_vscode
setup_bashpersonal
