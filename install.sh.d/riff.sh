#!/bin/bash -e
# DEPENDS: cargo

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions riff >/dev/null; then
        brew install riff
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! command -v riff >/dev/null; then
        cargo install riffdiff
    fi
fi
