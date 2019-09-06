#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions hub >/dev/null ; then
        brew install hub
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    sudo apt-get install snapd
    sudo snap install hub --classic
fi
