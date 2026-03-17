#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions pandoc >/dev/null ; then
        brew install pandoc
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s pandoc >/dev/null ; then
        sudo apt-get install pandoc
    fi
fi
