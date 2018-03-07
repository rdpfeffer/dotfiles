#!/usr/bin/env fish

# Update fish shell plugins.
fisher update

# Update hombrew.
brew update
brew upgrade
brew cleanup

# Update Mac apps.
mas upgrade