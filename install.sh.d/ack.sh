#!/bin/bash -e
# DEPENDS: stow

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions ack >/dev/null ; then
        brew install ack
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s ack-grep >/dev/null ; then
        sudo apt-get install ack-grep
    fi
fi

stow ack
