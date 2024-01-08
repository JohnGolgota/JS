#!/bin/bash

source /mnt/$1/.config/bashUtils/fn.sh

echo "update"
sudo apt-get update
echo "upgrade"
sudo apt-get upgrade

echo "install tools"
# Download and install
# avalible with apt-get
sudo apt-get install curl wget git zsh unzip gzip tar -y
# tools
sudo apt-get install tmux neovim -y


echo "init setup config"
setup_git
setup_nodejs
setup_nvim
use_vscode
setup_bashpersonal