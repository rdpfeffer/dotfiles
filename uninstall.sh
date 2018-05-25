#!/usr/bin/env bash

# Unstow rc files etc.
pushd "$HOME/dotfiles" || exit
stow -D git -D  vim -D postgres -D fish -D compat 
popd || exit

# remove the cache dir
rm -rf "$HOME/.cache"

# Remove all pip packages
pip2 freeze | xargs pip uninstall -y
pip3 freeze | xargs pip uninstall -y

# Remove all node packages
npm ls -gp --depth=0 \
    | awk -F/ '/node_modules/ && !/\/npm$/ {print $NF}' \
    | xargs npm -g rm

# Remove all gems
gem uninstall --all

# Remove all brewed packages
brew list | xargs brew uninstall
rm /usr/local/bin/vim

