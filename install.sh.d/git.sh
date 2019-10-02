#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions git >/dev/null ; then
        brew install git
    fi
    if ! brew ls --versions zaquestion/tap/lab >/dev/null ; then
        brew install zaquestion/tap/lab
    fi
    if ! [ -f $HOME/.cargo/bin/git-absorb ]; then
        sudo apt install --assume-yes cargo
        cargo install git-absorb
    fi
fi

stow git
