#!/bin/bash -e
# DEPENDS: brew

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions bat >/dev/null; then
        brew install bat
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # bat reached the Ubuntu archive in 22.04, which every Mint release still
    # supported is based on
    if ! dpkg -s bat >/dev/null 2>&1; then
        sudo apt-get install --yes bat
    fi
    # The Debian package ships the binary as batcat, to dodge a name clash with
    # bacula-console-qt. Link it under ~/.local/bin, which comes first in PATH.
    # Guarded, so that an older install from upstream's .deb (which does ship
    # /usr/bin/bat) is not shadowed by a dangling symlink.
    if [ -x /usr/bin/batcat ]; then
        mkdir -p "$HOME/.local/bin"
        ln -sf /usr/bin/batcat "$HOME/.local/bin/bat"
    fi
fi
