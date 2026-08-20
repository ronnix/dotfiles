#!/bin/bash -e
# DEPENDS: brew curl

# shellcheck source=lib/github.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/github.sh"

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions typst >/dev/null; then
        brew install typst
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! command -v typst >/dev/null; then
        TYPST_VERSION="$(github_latest_tag typst/typst)"
        curl -fsSL "https://github.com/typst/typst/releases/download/${TYPST_VERSION}/typst-x86_64-unknown-linux-musl.tar.xz" -o /tmp/typst.tar.xz
        tar -xf /tmp/typst.tar.xz -C /tmp
        mkdir -p "$HOME/.local/bin"
        mv /tmp/typst-x86_64-unknown-linux-musl/typst "$HOME/.local/bin/typst"
        rm -rf /tmp/typst.tar.xz /tmp/typst-x86_64-unknown-linux-musl
    fi
fi
