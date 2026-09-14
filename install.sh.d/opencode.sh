#!/bin/bash -e
# DEPENDS: brew stow

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions opencode >/dev/null; then
        brew install opencode
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # The official installer puts the binary under ~/.opencode/bin
    if needs_install test -x "${HOME}/.opencode/bin/opencode"; then
        curl -fsSL https://opencode.ai/install | bash
    fi
fi

stow opencode
