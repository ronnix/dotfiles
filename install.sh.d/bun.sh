#!/bin/bash -e
# DEPENDS: brew stow

if [ "$(uname -s)" == "Darwin" ]; then
    brew tap oven-sh/bun
    brew install bun
elif [ "$(uname -s)" == "Linux" ]; then
    curl -fsSL https://bun.sh/install | bash
fi

stow bun
