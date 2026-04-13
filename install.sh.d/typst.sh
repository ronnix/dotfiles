#!/bin/bash -e
# DEPENDS: brew curl

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions typst >/dev/null ; then
        brew install typst
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! command -v typst >/dev/null ; then
        TYPST_VERSION=$(curl -sL https://api.github.com/repos/typst/typst/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
        curl -sL "https://github.com/typst/typst/releases/download/${TYPST_VERSION}/typst-x86_64-unknown-linux-musl.tar.xz" -o /tmp/typst.tar.xz
        tar -xf /tmp/typst.tar.xz -C /tmp
        mkdir -p "$HOME/.local/bin"
        mv /tmp/typst-x86_64-unknown-linux-musl/typst "$HOME/.local/bin/typst"
        rm -rf /tmp/typst.tar.xz /tmp/typst-x86_64-unknown-linux-musl
    fi
fi
