#!/bin/bash

function make_link() {
    local source="$PWD/$1"
    local target="$HOME/$2"
    if [ -z "$2" ]; then
        target="$HOME/$(basename $1)"
    fi

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
    make_link "bash/.bash_profile"
    make_link "bash/.bashrc"
    make_link "bash/.inputrc"
    make_link "git/.gitconfig"
    make_link "git/.gitignore"
    make_link "hg/.hgrc"
    make_link "tmux/.tmux.conf"
    make_link "vim" ".vim"
    make_link "vim/.vimrc"
}

function link_local() {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        make_link "fontconfig/fonts.conf" ".config/fontconfig/fonts.conf"
        make_link "sublime-text/User" ".config/sublime-text-3/Packages/User"
        make_link "xfce/terminal" ".config/xfce4/terminal"
        make_link "x/.xmodmaprc"
        make_link "x/.xscreensaver"
        make_link "x/.xsessionrc"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        make_link "sublime-text/User" "Library/Application Support/Sublime Text 3/Packages/User"
        make_link "karabiner/private.xml" "Library/Application Support/Karabiner/private.xml"
    fi
}

function link_remote() {
    make_link "irssi/solarized.theme"
    make_link "screen/.screenrc"
}

while getopts clr opt; do
    case $opt in
        c) link_common;;
        l) link_local;;
        r) link_remote;;
    esac
done
