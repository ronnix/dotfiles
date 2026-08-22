#!/bin/bash -e
# DEPENDS: brew cargo

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions tokei >/dev/null; then
        brew install tokei
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # Upstream stopped attaching binaries to its releases after v13.0.0-alpha.0,
    # and the Ubuntu package only landed in 25.10, so build from crates.io
    if needs_install command -v tokei; then
        cargo install tokei
    fi
fi
