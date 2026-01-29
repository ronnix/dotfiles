#!/bin/bash -e
# DEPENDS: git

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions glab >/dev/null ; then
        brew install glab
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! [ -f /usr/bin/glab ]; then
        curl -s https://raw.githubusercontent.com/profclems/glab/trunk/scripts/install.sh | sudo bash
    fi
fi
