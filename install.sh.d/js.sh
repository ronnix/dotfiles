#!/bin/bash -e
# DEPENDS: curl stow

# 1) Install nvm
curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 2) Install latest LTS node version using nvm
nvm install --lts

# 3) Install config files
stow js

# 4)
# TODO: message to source files
