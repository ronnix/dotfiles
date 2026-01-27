#!/bin/bash -e
# DEPENDS: brew stow

# cf. https://direnv.net

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions direnv >/dev/null ; then
        brew install direnv
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s direnv >/dev/null ; then
        sudo apt-get install direnv
    fi
fi

stow direnv
