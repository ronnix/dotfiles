#!/bin/bash -e
# DEPENDS: brew stow

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions autojump >/dev/null ; then
        brew install autojump
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s autojump >/dev/null ; then
        sudo apt-get install --yes autojump
    fi
fi

stow autojump
