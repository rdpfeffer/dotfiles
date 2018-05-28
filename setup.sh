#!/usr/bin/env bash

cat << END
===============================================================================
Configuring MacOS
===============================================================================
END
source ./macos.sh


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
stow terninal

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
fisher


cat << END
===============================================================================
Loading Vim Modules
===============================================================================
END
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall


cat << END
===============================================================================
Building YCM 
===============================================================================
END
pushd ~/.vim/bundle/YouCompleteMe || exit
./install.py --all
popd || exit

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
