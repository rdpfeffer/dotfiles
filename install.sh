#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `install.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

cat << END
======================================
Installing xcode command line tools
======================================
END
xcode-select --install


cat << END
======================================
Installing Homebrew
======================================
END
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


cat << END
======================================
Making Homebrew auto update
======================================
END
brew install terminal-notifier
brew tap domt4/autoupdate
brew autoupdate --start --upgrade --cleanup --enable-notifications


cat << END
======================================
Installing essential tools
======================================
END
brew install heroku
brew install git
brew install ripgrep
brew install stow
brew install awscli
brew install cmake

cat << END
======================================
Installing Download utilities
======================================
END
brew install youtube-dl
brew install wget
brew install httpie


cat << END
======================================
Installing Fancy shell stuff
======================================
END
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
brew install homebrew/cask-fonts/font-roboto-mono-for-powerline

cat << END
======================================
Installing Bash Utilities
======================================
END
brew tap kaos/shell
brew install bats
brew install bats-assert
brew install bats-file
brew install shellcheck

cat << END
======================================
Installing Python Utilities
======================================
END
brew install python
brew install python@2
brew install pypy
brew install pypy3
brew install ipython
pip3 install legit
pip2 install em-keyboard
brew install pipenv
brew install pyenv

cat << END
======================================
Installing Git Utilities
======================================
END
brew install gist
brew install diff-so-fancy

cat << END
======================================
Installing Other languages
======================================
END
brew install lua
brew install node
brew install ruby

cat << END
======================================
Installing Fun stuff
======================================
END
brew install fortune
brew install cowsay
brew install sl
gem install lolcat

cat << END
======================================
Installing Network Utilities
======================================
END
brew install sshuttle
npm install --global speed-test

cat << END
======================================
Installing Go Toolchain
======================================
END
brew install go
brew install dep

cat << END
======================================
Installing Encryption Utilities
======================================
END
brew install gpg

# Pandoc
brew install pandoc


cat << END
======================================
Installing MacVim (and symlinking vim)
======================================
END
brew install macvim
ln -s /usr/local/bin/mvim /usr/local/bin/vim
