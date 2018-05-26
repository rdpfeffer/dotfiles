#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `uninstall.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo << END
======================================
Changing shell back to bash
======================================
END
chsh -s "$(which bash)" 

echo << END
======================================
Unstowing dotfiles
======================================
END
pushd "$HOME/dotfiles" || exit
stow -D git -D  vim -D postgres -D fish -D compat 
popd || exit

echo << END
======================================
Removing Cache Dir
======================================
END
# remove the cache dir
rm -rf "$HOME/.cache"

echo << END
======================================
Removing All Pip packages
======================================
END
pip2 freeze | xargs pip uninstall -y
pip3 freeze | xargs pip uninstall -y

echo << END
======================================
Removing All Node Packages
======================================
END
npm ls -gp --depth=0 \
    | awk -F/ '/node_modules/ && !/\/npm$/ {print $NF}' \
    | xargs npm -g rm

echo << END
======================================
Removing All Gem Packages
======================================
END
gem uninstall --all

echo << END
======================================
Removing All Brew Packages
======================================
END
brew list | xargs brew uninstall --force
rm /usr/local/bin/vim

tty=0 ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"

