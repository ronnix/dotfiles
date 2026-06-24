#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions shellcheck >/dev/null ; then
        brew install shellcheck
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s shellcheck >/dev/null ; then
        sudo apt-get install shellcheck
    fi
fi
