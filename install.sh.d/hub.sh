#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions hub >/dev/null ; then
        brew install hub
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s snapd >/dev/null ; then
        sudo apt-get install snapd
    fi
    if ! snap list hub >/dev/null ; then
        sudo snap install hub --classic
    fi
fi
