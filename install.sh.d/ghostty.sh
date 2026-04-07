#!/bin/bash -e
# DEPENDS: brew meslo-nerd-font stow

if [ "$(uname -s)" == "Darwin" ]; then
    # Install or upgrade
    if ! brew list --cask --versions ghostty > /dev/null ; then
        brew install --cask ghostty
    elif ! brew outdated --cask ghostty > /dev/null ; then
        brew upgrade --cask ghostty
    fi
fi

stow ghostty
