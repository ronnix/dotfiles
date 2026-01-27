#!/bin/bash -e
# DEPENDS: curl git

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions lab >/dev/null ; then
        brew install lab
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! [ -f /usr/bin/lab ]; then
        curl -s https://raw.githubusercontent.com/zaquestion/lab/master/install.sh | sudo bash
    fi
fi
