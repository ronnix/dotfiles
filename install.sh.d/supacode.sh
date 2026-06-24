#!/bin/bash -e
# DEPENDS: brew gh

if [ "$(uname -s)" == "Darwin" ]; then
    # Install or upgrade (supacode is a macOS-only cask, requires macOS 26 Tahoe)
    if ! brew list --cask --versions supacode > /dev/null ; then
        brew install --cask supacode
    elif ! brew outdated --cask supacode > /dev/null ; then
        brew upgrade --cask supacode
    fi
fi
