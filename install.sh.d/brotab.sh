#!/bin/bash -e
# DEPENDS: python

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

if needs_install test -d "$HOME/.local/pipx/venvs/brotab"; then
    # --force, so that --update reinstalls: a plain `pipx install` leaves an
    # existing venv alone and still exits 0
    pipx install --force brotab
    # Registers the native messaging host for the browser extension
    ~/.local/bin/brotab install
fi
