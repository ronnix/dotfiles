#!/bin/bash -e
# DEPENDS: curl stow

# shellcheck source=lib/github.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/github.sh"

# 1) Install nvm
NVM_VERSION="$(github_latest_tag nvm-sh/nvm)"
curl --silent -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 2) Install latest LTS node version using nvm
nvm install --lts

# 3) Install config files
stow js

# 4)
# TODO: message to source files
