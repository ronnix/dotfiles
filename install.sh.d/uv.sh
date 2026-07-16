#!/bin/bash -e
# DEPENDS: brew curl

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions uv >/dev/null; then
        brew install uv
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # No apt package, use the official installer from Astral
    if ! command -v uv >/dev/null; then
        curl -LsSf https://astral.sh/uv/install.sh | sh
    fi
fi
