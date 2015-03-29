#!/bin/bash

set -o errexit -o pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

plists=(
    "com.apple.symbolichotkeys"
    "com.divisiblebyzero.Spectacle"
    "com.googlecode.iterm2"
    "org.macosforge.xquartz.X11"
    "org.pqrs.Karabiner"
)

for plist in "${plists[@]}"; do
    local_file="$script_dir/plist/$plist.plist"
    if [[ "$1" == "save" ]]; then
       library_file="$HOME/Library/Preferences/$plist.plist"
       plutil -convert xml1 "$library_file" -o "$local_file"
    elif [[ "$1" == "apply" ]]; then
        defaults import "$plist" "$script_dir/plist/$plist.plist"
    fi
done
