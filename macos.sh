#!/usr/bin/env bash
set -euo pipefail

# Optional user preferences. Setup does not run this script.
# Do not change power management, backups, security checks, or system services.
if [[ "$(uname -s)" != Darwin ]]; then
    echo "These preferences require macOS." >&2
    exit 1
fi

# Use plain text and avoid automatic changes to code.
defaults write com.apple.TextEdit RichText -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Keep the existing screenshot and Dock preferences.
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
defaults write com.apple.screencapture type -string png
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock mru-spaces -bool false

echo "Preferences saved. Log out and back in to apply all changes."
