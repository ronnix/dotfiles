#!/bin/bash -e
# DEPENDS: stow

if [ "$(uname -s)" == "Linux" ]; then
    # kitty reached the Ubuntu archive in 22.04
    if ! dpkg -s kitty >/dev/null 2>&1; then
        sudo apt-get install --yes kitty
    fi
    # This script used to unpack upstream's tarball into ~/.local/kitty.app,
    # which .bashrc.d/kitty.sh still puts first in PATH; drop it so the packaged
    # binary wins
    rm -rf "$HOME/.local/kitty.app"
    stow kitty
fi
