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

# Load fish modules
fisher
