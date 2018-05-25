#!/usr/bin/env bash

source ./macos.sh

# Put in place all of our config files.
stow git
stow vim
stow postgres
stow fish
stow compat
# Change our shell to the fish shell.
chsh -s $"(which fish)"

#################################################################################
# Fish Plugins and Vim Modules must be added after stow has placed the
# config files describing which modules are used. 

# Fisherman (Fish Plugin manager)
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
# Load fish modules
fisher

# Load vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

pushd ~/.vim/bundle/YouCompleteMe
./install.py --all
popd
