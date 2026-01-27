#!/bin/bash -e

#
# Install GNU coreutils (needed for cross-platform compatibility)
#
if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions coreutils >/dev/null ; then
        brew install coreutils
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # coreutils is built-in on Linux
    echo "GNU coreutils already available on Linux"
fi
