#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions wget >/dev/null ; then
        brew install wget
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s wget >/dev/null ; then
        sudo apt-get install --yes wget
    fi
fi
