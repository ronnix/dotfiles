#!/bin/bash -e
# DEPENDS: coreutils starship stow

#
# Rename existing .zshrc to avoid conflicts
#
if [ -f ~/.zshrc ]; then
  if [ "$(uname -s)" == "Darwin" ]; then
    MV=gmv
  else
    MV=mv
  fi
  $MV --backup=numbered ~/.zshrc ~/.zshrc.orig
fi

stow zsh
