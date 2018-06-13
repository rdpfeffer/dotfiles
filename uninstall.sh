#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `uninstall.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

cat << END
======================================
Changing shell back to bash
======================================
END
chsh -s "$(which bash)" 

cat << END
======================================
Unstowing dotfiles
======================================
END
pushd "$HOME/dotfiles" || exit
stow -D git
stow -D vim
stow -D postgres
stow -D fish
stow -D compat
stow -D terminal
stow -D python
popd || exit

cat << END
======================================
Removing Remaining Dotfile Dirs
======================================
END
rm -rf "$HOME/.cache" "$HOME/.vim" "$HOME/.config"

cat << END
======================================
Removing All Pip packages
======================================
END
pip2 freeze | xargs pip uninstall -y
pip3 freeze | xargs pip uninstall -y

cat << END
======================================
Removing All Node Packages
======================================
END
npm ls -gp --depth=0 \
    | awk -F/ '/node_modules/ && !/\/npm$/ {print $NF}' \
    | xargs npm -g rm

cat << END
======================================
Removing All Gem Packages
======================================
END
gem uninstall --all --force --executables

cat << END
======================================
Removing All Brew Packages
======================================
END
brew list | xargs brew uninstall --force
rm /usr/local/bin/vim

tty=0 ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"

cat << END
======================================
Restoring Terminal to factory state
======================================
END
defaults delete com.apple.Terminal
rm ~/Library/Preferences/com.apple.Terminal.plist*
rm -rf ~/Library/Saved\ Application\ State/com.apple.Terminal.savedState/
killall Terminal
