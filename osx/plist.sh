#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

plists=(
    "com.divisiblebyzero.Spectacle.plist"
    "com.googlecode.iterm2.plist"
    "com.ragingmenace.MenuMeters.plist"
    "org.pqrs.Karabiner.plist"
    "org.pqrs.Seil.plist"
)

for plist in "${plists[@]}"; do
    local_file="$script_dir/plist/$plist"
    library_file="$HOME/Library/Preferences/$plist"
    if [[ "$1" == "export" ]]; then
       plutil -convert xml1 "$library_file" -o "$local_file"
    fi
done
