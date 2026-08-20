#!/bin/bash -e
# DEPENDS: curl gdebi

# shellcheck source=lib/github.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/github.sh"

# Unsloth Desktop (https://unsloth.ai/docs/desktop) is a Tauri app to run and
# train models locally. It has neither a Homebrew cask nor an apt repository,
# so install the artifacts published on GitHub releases.
# The app ships the Tauri updater and updates itself, hence the install-once
# checks below.

REPO="unslothai/unsloth"

if [ "$(uname -s)" == "Darwin" ]; then
    if [ ! -d "/Applications/Unsloth.app" ]; then
        if [ "$(uname -m)" != "arm64" ]; then
            echo "unsloth-desktop: only Apple Silicon is supported" >&2
            exit 1
        fi
        TAG="$(github_latest_tag "${REPO}")"
        VERSION="${TAG#v}"
        # Dots and dashes become underscores in the artifact names
        DMG="Unsloth-Desktop-${VERSION//[.-]/_}-MacOS.dmg"
        TMP="$(mktemp -d)"
        curl -fsSL "https://github.com/${REPO}/releases/download/v${VERSION}/${DMG}" -o "${TMP}/${DMG}"
        hdiutil attach -nobrowse -quiet -mountpoint "${TMP}/mnt" "${TMP}/${DMG}"
        ditto "${TMP}/mnt/Unsloth.app" "/Applications/Unsloth.app"
        hdiutil detach -quiet "${TMP}/mnt"
        rm -rf "${TMP}"
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s unsloth >/dev/null 2>&1; then
        if [ "$(dpkg --print-architecture)" != "amd64" ]; then
            echo "unsloth-desktop: only amd64 is supported" >&2
            exit 1
        fi
        TAG="$(github_latest_tag "${REPO}")"
        VERSION="${TAG#v}"
        DEB="Unsloth-Desktop-${VERSION//[.-]/_}-Ubuntu.deb"
        TMP="$(mktemp -d)"
        curl -fsSL "https://github.com/${REPO}/releases/download/v${VERSION}/${DEB}" -o "${TMP}/${DEB}"
        # gdebi pulls in the GTK/WebKit dependencies the package needs
        sudo gdebi --non-interactive "${TMP}/${DEB}"
        rm -rf "${TMP}"
    fi
fi
