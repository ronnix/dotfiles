#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions btop >/dev/null ; then
        brew install btop
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s btop >/dev/null ; then
        sudo apt-get install btop
    fi
fi
