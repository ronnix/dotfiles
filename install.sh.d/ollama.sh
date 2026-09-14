#!/bin/bash -e
# DEPENDS: brew

if [ "$(uname -s)" == "Darwin" ]; then
    # Guard on the binary rather than on the cask: ollama may already be there
    # from its standalone installer, and installing the cask on top of it would
    # leave two copies behind
    if ! command -v ollama >/dev/null; then
        brew install --cask ollama
    fi
fi
