#!/bin/bash -e
# DEPENDS: brew curl

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions uv >/dev/null; then
        brew install uv
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # No apt package, use the official installer from Astral
    if needs_install command -v uv; then
        curl -LsSf https://astral.sh/uv/install.sh | sh
    fi
fi
