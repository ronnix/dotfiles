#!/bin/bash -e
# DEPENDS: brew

if [ "$(uname -s)" == "Darwin" ]; then
    brew install biome
elif [ "$(uname -s)" == "Linux" ]; then
    curl -fsSL https://biomejs.dev/install.sh | bash
fi
