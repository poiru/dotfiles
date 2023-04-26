#!/bin/bash

set -o errexit -o pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function make_link() {
    local source="$script_dir/$1"
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

make_link "bash/.bash_profile"
make_link "bash/.bashrc"
make_link "bash/.inputrc"
make_link "bash/manpager.sh" ".manpager"
make_link "git/.gitconfig"
make_link "git/.gitignore"
make_link "lldb/.lldbinit"
make_link "screen/.screenrc"
make_link "vim" ".vim"
make_link "vim/.vimrc"
