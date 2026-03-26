#!/bin/bash -e
# DEPENDS: brew ollama

if [ "$(uname -s)" == "Darwin" ]; then
    brew tap yazinsai/openoats https://github.com/yazinsai/OpenOats
    brew install --cask yazinsai/openoats/openoats

    # Pull the embedding model used by OpenOats
    ollama pull nomic-embed-text

    echo "NOTE: Grant OpenOats microphone and screen recording permissions in"
    echo "  System Settings > Privacy & Security > Microphone"
    echo "  System Settings > Privacy & Security > Screen & System Audio Recording"
fi
