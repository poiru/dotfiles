#!/bin/sh

for name in src/*; do
  source="$PWD/$name"
  target="$HOME/.$(basename $name)"
  if [ -e "$target" ]; then
    if [ ! -L "$target" ]; then
      echo "WARNING: $target exists and is not a symlink."
    fi
  else
    echo "Creating $target"
    ln -s "$source" "$target"
  fi
done
