#!/bin/bash -e
# DEPENDS: brew stow

if [ "$(uname -s)" == "Darwin" ]; then
    brew install opencode
elif [ "$(uname -s)" == "Linux" ]; then
    curl -fsSL https://opencode.ai/install | bash
fi

stow opencode
