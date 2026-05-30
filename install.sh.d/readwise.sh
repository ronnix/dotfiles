#!/bin/bash -e
# DEPENDS: js

# Charge nvm pour disposer de node/npm (installés par js.sh)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Installe la CLI Readwise (https://readwise.io/cli)
if ! command -v readwise >/dev/null ; then
    npm install -g @readwise/cli
fi

# Authentification (à faire manuellement une fois installé) :
#   readwise login                     # OAuth via navigateur
#   readwise login-with-token <token>  # environnements sans navigateur
