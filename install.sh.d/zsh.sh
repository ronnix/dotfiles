#!/bin/bash -e
# DEPENDS: coreutils starship stow

#
# Rename existing dotfiles to avoid stow conflicts
#
if [ "$(uname -s)" == "Darwin" ]; then
  MV=gmv
else
  MV=mv
fi

for f in ~/.zshrc ~/.zprofile; do
  if [ -f "$f" ]; then
    $MV --backup=numbered "$f" "$f.orig"
  fi
done

stow zsh
