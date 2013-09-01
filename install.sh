#!/bin/bash

declare -A map
map["src/.bashrc"]=".bashrc"
map["src/.gitconfig"]=".gitconfig"
map["src/.hgrc"]=".hgrc"
map["src/.vim"]=".vim"
map["src/.vimrc"]=".vimrc"
map["src/.xfce-terminalrc"]=".config/Terminal/terminalrc"
map["src/.xmodmaprc"]=".xmodmaprc"
map["src/.xsessionrc"]=".xsessionrc"

for file in "${!map[@]}"
do
    source="$PWD/$file"
    target="$HOME/${map[$file]}"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        read -r -p "Non-symlink $target already exists. Overwrite [y/n]? " yn
        if [[ ! $yn =~ ^[Yy]$ ]]; then
            continue
        fi
    fi

    echo "Creating symlink $target"
    unlink "$target"
    ln -s "$source" "$target"
done