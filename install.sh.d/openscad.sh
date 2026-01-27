#!/bin/bash -e
# DEPENDS: brew stow

if [ "$(uname -s)" == "Darwin" ]; then
    # Install or upgrade
    if ! brew list --cask --versions openscad@snapshot > /dev/null ; then
        brew install openscad@snapshot
    elif ! brew outdated --cask openscad@snapshot > /dev/null ; then
        brew upgrade openscad@snapshot
    fi
fi
