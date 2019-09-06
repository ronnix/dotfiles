#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions git >/dev/null ; then
        brew install git
    fi
    if ! brew ls --versions zaquestion/tap/lab >/dev/null ; then
        brew install zaquestion/tap/lab
    fi
fi

stow git
