#!/bin/bash -e
# DEPENDS: brew curl

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions hunk >/dev/null; then
        brew install hunk
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # Hunk has no apt repository, so install the standalone binary from GitHub releases
    if ! command -v hunk >/dev/null; then
        case "$(uname -m)" in
            x86_64) ARCH="x64" ;;
            aarch64 | arm64) ARCH="arm64" ;;
            *)
                echo "Unsupported architecture: $(uname -m)" >&2
                exit 1
                ;;
        esac
        VERSION="$(curl -fsSL https://api.github.com/repos/modem-dev/hunk/releases/latest |
            grep -oP '"tag_name":\s*"v\K[^"]+')"
        TARBALL="hunkdiff-linux-${ARCH}.tar.gz"
        URL="https://github.com/modem-dev/hunk/releases/download/v${VERSION}/${TARBALL}"
        TMP="$(mktemp -d)"
        curl -fsSL "${URL}" | tar xz -C "${TMP}"
        mkdir -p "$HOME/.local/bin"
        install -m 755 "${TMP}/hunkdiff-linux-${ARCH}/hunk" "$HOME/.local/bin/hunk"
        rm -rf "${TMP}"
    fi
fi
