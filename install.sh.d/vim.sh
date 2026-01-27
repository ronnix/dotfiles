#!/bin/bash -e
# DEPENDS: stow

if [ "$(uname -s)" == "Darwin" ]; then
    # vim is already installed on macOS
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s vim >/dev/null ; then
        sudo apt-get install vim
    fi
fi

stow vim
