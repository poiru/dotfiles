#!/usr/bin/env bash

set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ask for the administrator password upfront.
sudo -v

# Mute on logout.
sudo cp "$script_dir/mute.sh" /var/root
sudo chmod +x /var/root/mute.sh
sudo defaults write com.apple.loginwindow LogoutHook /var/root/mute.sh

# Don't reopen windows when logging back in.
defaults write com.apple.loginwindow TALLogoutSavesState -bool false

# Disable Spotlight and hide the menu bar icon.
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist
sudo sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# Disable Notification Center.
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist

# Show remaining battery time; hide percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Make key repeating work.
defaults write -g ApplePressAndHoldEnabled -bool false

# Disable smart quotes and dashes as they’re annoying when typing code.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Enable tap to click for this user and for the login screen.
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable full keyboard access for all controls.
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable auto-correct.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable shadow in screenshots.
defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs.
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Finder preferences.
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write -g AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network volumes.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Automatically open a new Finder window when a volume is mounted.
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Disable Dashboard.
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space.
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use.
defaults write com.apple.dock mru-spaces -bool false

# Dock preferences.
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.4
defaults write com.apple.dock orientation -string "bottom"
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock tilesize -int 48

# Disable XCode indexing.
defaults write com.apple.dt.XCode IDEIndexDisable -int 1

# Ask for password after screensaver appears.
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 1

# Expand save/print panels by default.
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Airplay preferences.
defaults write com.apple.airplay.plist showInMenuBarIfPresent -bool false

# Clock preferences.
defaults write com.apple.menuextra.clock -string "EEE d MMM  HH:mm"

# Sound preferences.
defaults write com.apple.systemsound com.apple.sound.beep.volume -float 0.0
defaults write com.apple.systemsound com.apple.sound.uiaudio.enabled -int 0

# Kill affected apps.
for app in "Dock" "Finder" "SystemUIServer"; do
    killall "${app}" > /dev/null 2>&1
done
