#!/bin/bash -e
# DEPENDS: stow

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions parallel >/dev/null ; then
        brew install parallel
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s parallel >/dev/null ; then
        sudo apt-get install parallel
    fi
fi
