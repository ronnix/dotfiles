#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions jq >/dev/null ; then
        brew install jq
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s jq >/dev/null ; then
        sudo apt-get install jq
    fi
fi
