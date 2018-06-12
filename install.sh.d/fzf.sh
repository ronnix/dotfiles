#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions fzf >/dev/null ; then
        brew install fzf
    fi
    stow fzf
fi
