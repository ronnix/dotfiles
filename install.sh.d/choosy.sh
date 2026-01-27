#!/bin/bash -e
# DEPENDS: brew

if [ "$(uname -s)" == "Darwin" ]; then
    # Install or upgrade
    if ! brew list --cask --versions choosy > /dev/null ; then
        brew install choosy
    elif ! brew outdated --cask choosy > /dev/null ; then
        brew upgrade choosy
    fi
fi
