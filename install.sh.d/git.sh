#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    brew install git
    brew install hub
    brew install zaquestion/tap/lab
fi

stow git
