#!/bin/bash -e
# DEPENDS: brew

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

if [ "$(uname -s)" == "Darwin" ]; then
    # Install or upgrade
    if ! brew list --versions skillshare >/dev/null; then
        brew install skillshare
    elif ! brew outdated skillshare >/dev/null; then
        brew upgrade skillshare
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if needs_install command -v skillshare; then
        curl -fsSL https://raw.githubusercontent.com/runkids/skillshare/main/install.sh | sh
    fi
fi
