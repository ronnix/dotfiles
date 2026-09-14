#!/bin/bash -e
# DEPENDS: python

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

# Frogmouth 0.9.2 is incompatible with Python 3.14 (httpcore typing issue).
if needs_install test -d "$HOME/.local/pipx/venvs/frogmouth"; then
    # --force, so that --update reinstalls: a plain `pipx install` leaves an
    # existing venv alone and still exits 0
    pipx install --force --python "$(pyenv which python3.13)" frogmouth
fi
