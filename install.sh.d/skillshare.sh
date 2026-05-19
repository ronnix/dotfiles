#!/bin/bash -e
# DEPENDS: brew

if [ "$(uname -s)" == "Darwin" ]; then
    # Install or upgrade
    if ! brew list --versions skillshare > /dev/null ; then
        brew install skillshare
    elif ! brew outdated skillshare > /dev/null ; then
        brew upgrade skillshare
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! command -v skillshare >/dev/null ; then
        curl -fsSL https://raw.githubusercontent.com/runkids/skillshare/main/install.sh | sh
    fi
fi
