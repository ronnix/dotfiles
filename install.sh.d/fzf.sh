#!/bin/bash -e
# DEPENDS: stow

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions fzf >/dev/null ; then
        brew install fzf
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s fzf >/dev/null ; then  
        sudo apt-get update
        sudo apt-get install --yes fzf
    fi
fi

stow fzf
