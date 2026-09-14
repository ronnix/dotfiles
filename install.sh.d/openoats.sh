#!/bin/bash -e
# DEPENDS: brew ollama

if [ "$(uname -s)" == "Darwin" ]; then
    brew tap yazinsai/openoats https://github.com/yazinsai/OpenOats
    brew trust --cask yazinsai/openoats/openoats
    if ! brew list --cask --versions openoats >/dev/null; then
        brew install --cask yazinsai/openoats/openoats
    fi

    # Pull the embedding model used by OpenOats
    if ! ollama list 2>/dev/null | grep -q '^nomic-embed-text'; then
        ollama pull nomic-embed-text
    fi

    echo "NOTE: Grant OpenOats microphone and screen recording permissions in"
    echo "  System Settings > Privacy & Security > Microphone"
    echo "  System Settings > Privacy & Security > Screen & System Audio Recording"
fi
