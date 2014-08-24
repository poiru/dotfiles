#!/bin/bash

function make_link() {
    local source="$PWD/src/$1"
    local target=$([ $# == 2 ] && echo "$HOME/$2" || echo "$HOME/$1")

    # Ensure that target directory exists.
    local target_dir="${target%/*}"
    if [ ! -e "$target_dir" ]; then
        read -r -p "Create directory for '$target' [y/n]? " yn
        if [[ ! $yn =~ ^[Yy]$ ]]; then
            return
        fi

        mkdir -p "$target_dir"
    fi

    if [ -L "$target" ]; then
        unlink "$target"
    fi

    if [ -d "$target" ]; then
        read -r -p "Directory '$target' already exists. Overwrite [y/n]? " yn
        if [[ ! $yn =~ ^[Yy]$ ]]; then
            return
        fi

        rm -rf "$target"
    elif [ -e "$target" ]; then
        read -r -p "Non-symlink '$target' already exists. Overwrite [y/n]? " yn
        if [[ ! $yn =~ ^[Yy]$ ]]; then
            return
        fi

        rm "$target"
    fi

    echo "Creating symlink $target"
    ln -s "$source" "$target"
}

function link_common() {
    make_link ".bash_profile"
    make_link ".bashrc"
    make_link ".gitconfig"
    make_link ".gitignore"
    make_link ".hgrc"
    make_link ".inputrc"
    make_link ".tmux.conf"
    make_link ".vim"
    make_link ".vimrc"
}

function link_local() {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        make_link ".fonts.conf" ".config/fontconfig/fonts.conf"
        make_link ".xfce-terminalrc" ".config/Terminal/terminalrc"
        make_link ".xmodmaprc"
        make_link ".xscreensaver"
        make_link ".xsessionrc"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        make_link "sublime-text/User" "Library/Application Support/Sublime Text 3/Packages/User"
        make_link "karabiner/private.xml" "Library/Application Support/Karabiner/private.xml"
    fi
}

function link_remote() {
    make_link ".irssi/solarized.theme"
    make_link ".screenrc"
}

while getopts clr opt; do
    case $opt in
        c) link_common;;
        l) link_local;;
        r) link_remote;;
    esac
done
