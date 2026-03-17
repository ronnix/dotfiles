#!/bin/bash -e
# DEPENDS: brew

if [ "$(uname -s)" == "Darwin" ]; then
    brew install --cask lm-studio
fi

stow lm-studio
