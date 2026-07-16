#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions glow >/dev/null; then
        brew install glow
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s glow >/dev/null; then
        sudo apt-get install glow
    fi
fi
