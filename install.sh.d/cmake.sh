#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions cmake >/dev/null; then
        brew install cmake
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s cmake >/dev/null; then
        sudo apt-get install cmake
    fi
fi
