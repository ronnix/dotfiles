#!/bin/bash -e
# DEPENDS: cargo

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions riff >/dev/null; then
        brew install riff
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if needs_install command -v riff; then
        cargo install riffdiff
    fi
fi
