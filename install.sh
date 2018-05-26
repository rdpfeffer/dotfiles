#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `install.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Xcode Command Line Tools.
xcode-select --install

# Install Homebrew.
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install brew basics (auto-updating).
brew install terminal-notifier
brew tap domt4/autoupdate
brew autoupdate --start --upgrade --cleanup --enable-notifications

# Install brew essentials.
brew install heroku
brew install git
brew install ack
brew install stow
brew install awscli

# Install download utilities.
brew install youtube-dl
brew install wget
brew install httpie

# Install fancy shell stuff.
brew install fish
brew install grc
brew install direnv
brew install nnn
brew install thefuck
brew install autojump
brew install googler
brew install mas
brew install htop
brew install neofetch
brew install mosh

# Install bash utilities.
brew tap kaos/shell
brew install bats
brew install bats-assert
brew install bats-file
brew install shellcheck

# Install Python utlitlies.
brew install python
brew install python@2
brew install pypy
brew install pypy3
brew install ipython

# Python utilities.
pip3 install legit
pip2 install em-keyboard

# Pipenv!
brew install pipenv

# Install git utilities.
brew install gist

# Install other languages.
brew install lua
brew install node
brew install ruby

# Install fun stuff.
brew install fortune
brew install cowsay
brew install sl
gem install lolcat

# Install network utilities
brew install sshuttle
npm install --global speed-test

# Go stuff.
brew install go
brew install dep

# GPG stuff.
brew install gpg

# Pandoc
brew install pandoc

# Mac Vim and link vim to mvim
brew install macvim
ln -s /usr/local/bin/vim /usr/local/bim/mvim
