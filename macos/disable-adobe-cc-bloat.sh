#!/usr/bin/env bash

# Prevent useless Adobe CC daemons from launching on startup.
sudo mv /Library/LaunchAgents/com.adobe.AAM.Updater-1.0.plist{,.disabled}
sudo mv /Library/LaunchAgents/com.adobe.AdobeCreativeCloud.plist{,.disabled}
sudo mv /Library/LaunchDaemons/com.adobe.adobeupdatedaemon.plist{,.disabled}
sudo mv /Library/LaunchDaemons/com.adobe.agsservice.plist{,.disabled}

# Prevent the Adobe CC updater from launching on startup. We replace the file
# with a dummy file to prevent CC from recreating it.
rm ~/Library/LaunchAgents/com.adobe.AAM.Updater-1.0.plist
defaults write ~/Library/LaunchAgents/com.adobe.AAM.Updater-1.0.plist Label -string "com.adobe.AAM.Scheduler-1.0"
