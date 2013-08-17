#!/bin/bash

declare -A map
map["src/bashrc"]=".bashrc"
map["src/gitconfig"]=".gitconfig"
map["src/hgrc"]=".hgrc"
map["src/vim"]=".vim"
map["src/vimrc"]=".vimrc"
map["src/xfce-terminalrc"]=".config/Terminal/terminalrc"

for file in "${!map[@]}"
do
  source="$PWD/$file"
  target="$HOME/${map[$file]}"
  if [ -e "$target" ]; then
    if [ ! -L "$target" ]; then
      echo "WARNING: $target exists and is not a symlink."
    fi
  else
    echo "Creating $target"
    ln -s "$source" "$target"
  fi
done