#!/usr/bin/env bash

cat << END
===============================================================================
Configuring MacOS
===============================================================================
END
source ./macos.sh
touch ~/.hushlogin


cat << END
===============================================================================
Loading RC Files
===============================================================================
END
stow git
stow vim
stow postgres
stow fish
stow compat
stow python

rm "$HOME/Library/Preferences/com.apple.Terminal.plist"
rm -rf "$HOME/Library/Saved Application State/com.apple.Terminal.savedState"
stow terminal

cat << END
===============================================================================
Changing to the fish shell
===============================================================================
END
# Change our shell to the fish shell.
chsh -s "$(which fish)"

cat << END
===============================================================================
Restoring Terminal Settings
===============================================================================
END
defaults import com.apple.Terminal - < "$HOME/dotfiles/terminal/Terminal_defaults.xml"

cat << END
===============================================================================
Loading Fisherman Modules
===============================================================================
END
# Fish Plugins and Vim Modules must be added after stow has placed the
# config files describing which modules are used. 

# Fisherman (Fish Plugin manager)
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
# Load fish modules
fish -c fisher


cat << END
===============================================================================
Loading Vim Modules
===============================================================================
END
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -e +PlugInstall +qall


cat << END
===============================================================================
Building YCM 
===============================================================================
END
pushd ~/.vim/plugged/YouCompleteMe || exit
./install.py --clang-completer --go-completer --java-completer
popd || exit

cat << END
===============================================================================
Installing ASDF Plugins
===============================================================================
END
asdf plugin-add python
asdf install python 3.7.4
asdf install python 2.7.16
asdf global python 3.7.4 2.7.16


cat << END
===============================================================================
Restarting applications 
===============================================================================
END
read -p "Restarting Applications. Ready to restart? [Y/n]" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
 for app in "Activity Monitor" \
	"Address Book" \
	"Calendar" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Google Chrome Canary" \
	"Google Chrome" \
	"Mail" \
	"Messages" \
	"Photos" \
	"Safari" \
	"SystemUIServer" \
	"Terminal"; do
	killall "${app}" &> /dev/null
  done
fi

echo "Done. Note that some of these changes require a logout/restart to take effect."
