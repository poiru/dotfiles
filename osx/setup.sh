#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Disable the sound effects on boot.
sudo nvram SystemAudioVolume=" "

# Disable Spotlight and hide the menu bar icon.
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist
sudo sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# Disable Notification Center.
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist

# Show remaining battery time; hide percentage
defaults write com.apple.menuextra.battery ShowPercent -string "NO"
defaults write com.apple.menuextra.battery ShowTime -string "YES"

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

# Finder: Show hidden files by default.
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write -g AppleShowAllFiles -bool true

# Finder: Show all filename extensions.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: Show path bar.
defaults write com.apple.finder ShowPathbar -bool true

# Finder: Display full POSIX path as window title.
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Finder: Disable the warning when changing a file extension.
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

# Remove the auto-hiding Dock delay.
defaults write com.apple.dock autohide-delay -float 0

# Set the animation delay for hiding/showing the Dock.
defaults write com.apple.dock autohide-time-modifier -float 0.4

# Make Dock icons of hidden applications translucent.
defaults write com.apple.dock showhidden -bool true

# Disable XCode indexing.
defaults write com.apple.dt.XCode IDEIndexDisable 1

# Kill affected apps.
for app in "Dock" "Finder" "SystemUIServer"; do
    killall "${app}" > /dev/null 2>&1
done
