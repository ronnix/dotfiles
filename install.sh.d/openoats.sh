#!/bin/bash -e
# DEPENDS: brew

if [ "$(uname -s)" == "Darwin" ]; then
    brew tap yazinsai/openoats https://github.com/yazinsai/OpenOats
    brew trust --cask yazinsai/openoats/openoats
    if ! brew list --cask --versions openoats >/dev/null; then
        brew install --cask yazinsai/openoats/openoats
    fi

    # Pull the embedding model used by OpenOats. Ollama is no longer installed
    # by this repository, so skip the pull when it is not around.
    if command -v ollama >/dev/null && ! ollama list 2>/dev/null | grep -q '^nomic-embed-text'; then
        ollama pull nomic-embed-text
    fi

    echo "NOTE: Grant OpenOats microphone and screen recording permissions in"
    echo "  System Settings > Privacy & Security > Microphone"
    echo "  System Settings > Privacy & Security > Screen & System Audio Recording"
fi
