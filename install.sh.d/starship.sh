#!/bin/bash -e
# DEPENDS: brew meslo-nerd-font

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions starship >/dev/null; then
        brew install starship
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s stow >/dev/null; then
        sudo apt-get install stow
    fi
fi

# Installe la configuration
stow starship
