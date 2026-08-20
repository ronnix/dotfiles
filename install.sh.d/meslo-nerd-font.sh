#!/bin/bash -e
# DEPENDS: brew curl

# shellcheck source=lib/github.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/github.sh"

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions font-meslo-lg-nerd-font >/dev/null; then
        brew install --cask font-meslo-lg-nerd-font
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    FONT_DIR="$HOME/.local/share/fonts"
    if ! ls "${FONT_DIR}"/Meslo* >/dev/null 2>&1; then
        TAG="$(github_latest_tag ryanoasis/nerd-fonts)"
        TMP="$(mktemp -d)"
        curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/download/${TAG}/Meslo.zip" \
            -o "${TMP}/Meslo.zip"
        mkdir -p "${FONT_DIR}"
        unzip -o -q "${TMP}/Meslo.zip" -d "${FONT_DIR}"
        rm -rf "${TMP}"
        fc-cache -f
    fi
fi
