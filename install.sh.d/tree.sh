#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions tree >/dev/null ; then
        brew install tree
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s tree >/dev/null ; then
        sudo apt-get install tree
    fi
fi
