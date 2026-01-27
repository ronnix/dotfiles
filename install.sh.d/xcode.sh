#!/bin/bash -e

# Make sure XCode command-line tools are up-to-date on macOS
# see: https://github.com/pyenv/pyenv/issues/530
if [ "$(uname -s)" == "Darwin" ]; then
    xcode-select --install 2>/dev/null || true
fi
