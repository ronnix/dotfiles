#!/bin/bash -e
# DEPENDS: brew stow

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

if [ "$(uname -s)" == "Darwin" ]; then
    brew trust --formula oven-sh/bun/bun
    if ! brew ls --versions bun >/dev/null; then
        brew install oven-sh/bun/bun
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # The official installer puts the binary under ~/.bun/bin
    if needs_install test -x "${HOME}/.bun/bin/bun"; then
        curl -fsSL https://bun.sh/install | bash
    fi
fi

stow bun
