#!/bin/bash -e
# DEPENDS: stow 

#
# Rename existing .bashrc to avoid conflicts
#
if [ -f ~/.bashrc ]; then
  if command -v gmv >/dev/null; then
    MV=gmv
  else
    MV=mv
  fi
  $MV --backup=numbered ~/.bashrc ~/.bashrc.orig
fi

stow bash
