#!/bin/bash -e
# DEPENDS: brew

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions stow >/dev/null ; then
        brew install stow
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s stow >/dev/null ; then
        sudo apt-get install stow
    fi
fi
