#!/usr/bin/env fish

# Update fish shell plugins.
fisher update

# Update hombrew.
brew update
brew upgrade
brew cleanup

# Python 2 utilities.
pip3 install --upgrade legit
pip2 install --upgrade em-keyboard

# Heroku plugins.
heroku plugins:update

# Update Mac apps.
mas upgrade