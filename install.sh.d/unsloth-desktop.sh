#!/bin/bash -e
# DEPENDS: brew curl gdebi

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

# Unsloth Desktop (https://unsloth.ai/docs/desktop) is a Tauri app to run and
# train models locally.

if [ "$(uname -s)" == "Darwin" ]; then
    if needs_install brew list --cask --versions unsloth; then
        # The app may already be in /Applications: installed by hand before the
        # cask existed, or kept current by its own updater. --adopt lets brew
        # take it over in place rather than refusing to overwrite it. Adoption
        # needs the versions to match, and the self-updater can run ahead of the
        # cask, so leave the app alone when it fails: it updates itself anyway.
        brew install --cask --adopt unsloth ||
            echo "unsloth-desktop: leaving the app in place, to its own updater" >&2
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # No apt repository, so install the .deb published on GitHub releases.
    # Unlike the macOS app, the package does not update itself: upstream's
    # updater is AppImage-oriented, so --update is the only way forward.
    if needs_install dpkg -s unsloth; then
        if [ "$(dpkg --print-architecture)" != "amd64" ]; then
            # Skip rather than fail, so one unsupported module does not abort
            # the whole install.sh run
            echo "unsloth-desktop: only amd64 is supported, skipping" >&2
            exit 0
        fi
        TAG="$(github_latest_tag unslothai/unsloth)"
        DEB="$(github_release_asset unslothai/unsloth "${TAG}" -Ubuntu.deb)"
        TMP="$(mktemp -d)"
        curl -fsSL "https://github.com/unslothai/unsloth/releases/download/${TAG}/${DEB}" -o "${TMP}/${DEB}"
        # gdebi pulls in the GTK/WebKit dependencies the package needs
        sudo gdebi --non-interactive "${TMP}/${DEB}"
        rm -rf "${TMP}"
    fi
fi
