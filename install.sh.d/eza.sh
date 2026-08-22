#!/bin/bash -e
# DEPENDS: brew curl

# eza succeeds exa, whose last release dates back to April 2021.

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions eza >/dev/null; then
        brew install eza
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if needs_install command -v eza; then
        # eza only reached the Ubuntu archive in 24.04 (Mint 22), so fall back
        # to the upstream binary on older releases
        if apt-cache show eza >/dev/null 2>&1; then
            sudo apt-get install --yes eza
        else
            TAG="$(github_latest_tag eza-community/eza)"
            URL="https://github.com/eza-community/eza/releases/download/${TAG}/eza_x86_64-unknown-linux-gnu.tar.gz"
            TMP="$(mktemp -d)"
            curl -fsSL "${URL}" | tar xz -C "${TMP}"
            mkdir -p "$HOME/.local/bin"
            install -m 755 "${TMP}/eza" "$HOME/.local/bin/eza"
            rm -rf "${TMP}"
        fi
    fi
fi
