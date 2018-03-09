#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    brew install git
    brew install hub
fi

stow git
