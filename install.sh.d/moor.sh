#!/bin/bash -e
# DEPENDS: curl

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions moor >/dev/null; then
        brew install moor
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if needs_install command -v moor; then
        arch="$(uname -m)"
        case "$arch" in
            x86_64) arch=amd64 ;;
            aarch64) arch=arm64 ;;
        esac
        version="$(github_latest_tag walles/moor)"
        curl -fsSL "https://github.com/walles/moor/releases/download/${version}/moor-${version}-linux-${arch}" -o /tmp/moor
        sudo install -m 0755 /tmp/moor /usr/local/bin/moor
        rm /tmp/moor
    fi
fi
