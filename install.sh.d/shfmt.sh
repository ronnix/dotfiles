#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions shfmt >/dev/null; then
        brew install shfmt
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s shfmt >/dev/null; then
        sudo apt-get install shfmt
    fi
fi
