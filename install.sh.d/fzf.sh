#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions fzf >/dev/null ; then
        brew install fzf
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    sudo apt-get install --yes fzf
fi
stow fzf
