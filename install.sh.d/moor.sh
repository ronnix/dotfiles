#!/bin/bash -e
# DEPENDS: curl

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions moor >/dev/null ; then
        brew install moor
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! command -v moor >/dev/null ; then
        arch="$(uname -m)"
        case "$arch" in
            x86_64) arch=amd64 ;;
            aarch64) arch=arm64 ;;
        esac
        version="$(curl -fsSL https://api.github.com/repos/walles/moor/releases/latest | grep -m1 tag_name | cut -d'"' -f4)"
        curl -fsSL "https://github.com/walles/moor/releases/download/${version}/moor-${version}-linux-${arch}" -o /tmp/moor
        sudo install -m 0755 /tmp/moor /usr/local/bin/moor
        rm /tmp/moor
    fi
fi
