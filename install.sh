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

    # Ensure that the target is either a symlink or does not exist at all.
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        read -r -p "Non-symlink '$target' already exists. Overwrite [y/n]? " yn
        if [[ ! $yn =~ ^[Yy]$ ]]; then
            return
        fi
    fi

    echo "Creating symlink $target"
    if [ -L "$target" ]; then
        unlink "$target"
    fi
    ln -fs "$source" "$target"
}

function link_common() {
    make_link ".bash_profile"
    make_link ".bashrc"
    make_link ".gitconfig"
    make_link ".hgrc"
    make_link ".inputrc"
    make_link ".vim"
    make_link ".vimrc"
}

function link_local() {
    make_link ".fonts.conf" ".config/fontconfig/fonts.conf"
    make_link ".xfce-terminalrc" ".config/Terminal/terminalrc"
    make_link ".xmodmaprc"
    make_link ".xscreensaver"
    make_link ".xsessionrc"
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