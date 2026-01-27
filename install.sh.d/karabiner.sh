#!/bin/bash -e
# DEPENDS: brew stow

if [ "$(uname -s)" == "Darwin" ]; then
    # Install or upgrade
    if ! brew list --cask --versions karabiner-elements > /dev/null ; then
        brew install karabiner-elements
    elif ! brew outdated --cask karabiner-elements > /dev/null ; then
        brew upgrade karabiner-elements
    fi
    # Install config files
    stow karabiner
fi
