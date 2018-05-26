#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `install.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo << END
======================================
Installing xcode command line tools
======================================
END
xcode-select --install


echo << END
======================================
Installing Homebrew
======================================
END
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


echo << END
======================================
Making Homebrew auto update
======================================
END
brew install terminal-notifier
brew tap domt4/autoupdate
brew autoupdate --start --upgrade --cleanup --enable-notifications


echo << END
======================================
Installing essential tools
======================================
END
brew install heroku
brew install git
brew install ack
brew install stow
brew install awscli


echo << END
======================================
Installing Download utilities
======================================
END
brew install youtube-dl
brew install wget
brew install httpie


echo << END
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

echo << END
======================================
Installing Bash Utilities
======================================
END
brew tap kaos/shell
brew install bats
brew install bats-assert
brew install bats-file
brew install shellcheck

echo << END
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

echo << END
======================================
Installing Git Utilities
======================================
END
brew install gist

echo << END
======================================
Installing Other languages
======================================
END
brew install lua
brew install node
brew install ruby

echo << END
======================================
Installing Fun stuff
======================================
END
brew install fortune
brew install cowsay
brew install sl
gem install lolcat

echo << END
======================================
Installing Network Utilities
======================================
END
brew install sshuttle
npm install --global speed-test

echo << END
======================================
Installing Go Toolchain
======================================
END
brew install go
brew install dep

echo << END
======================================
Installing Encryption Utilities
======================================
END
brew install gpg

# Pandoc
brew install pandoc


echo << END
======================================
Installing MacVim (and symlinking vim)
======================================
END
brew install macvim
ln -s /usr/local/bin/vim /usr/local/bin/mvim
