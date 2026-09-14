#!/bin/bash -e
# DEPENDS: curl stow

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

export NVM_DIR="$HOME/.nvm"

# 1) Install nvm. It is a shell function rather than a binary, so look for the
# script it is loaded from instead of using command -v.
if needs_install test -s "$NVM_DIR/nvm.sh"; then
    NVM_VERSION="$(github_latest_tag nvm-sh/nvm)"
    curl --silent -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
fi
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 2) Install latest LTS node version using nvm
if needs_install command -v node; then
    nvm install --lts
fi

# 3) Install config files
stow js

# 4)
# TODO: message to source files
