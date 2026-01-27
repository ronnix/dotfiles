#!/bin/bash -e
# DEPENDS: git stow

TALISMAN_VERSION="v1.32.0"
TALISMAN_HOME="${HOME}/.talisman/bin"

if ! command -v talisman &> /dev/null; then
    if [ "$(uname -s)" == "Darwin" ]; then
        if ! brew ls --versions talisman >/dev/null ; then
            brew install talisman
        fi
    elif [ "$(uname -s)" == "Linux" ]; then
        TALISMAN_URL="https://github.com/thoughtworks/talisman/releases/download/${TALISMAN_VERSION}/talisman_linux_amd64"
        DEST=~/.local/bin
        mkdir -p ${DEST}
        curl -L ${TALISMAN_URL} -o ${DEST}/talisman
        chmod +x ${DEST}/talisman
    fi
fi

# Install talisman_hook_script
mkdir -p "${TALISMAN_HOME}"
HOOK_SCRIPT_URL="https://raw.githubusercontent.com/thoughtworks/talisman/${TALISMAN_VERSION}/global_install_scripts/talisman_hook_script.bash"
curl -L "${HOOK_SCRIPT_URL}" -o "${TALISMAN_HOME}/talisman_hook_script"
chmod +x "${TALISMAN_HOME}/talisman_hook_script"

# Configure global git hook via stow
git config --global init.templateDir "${HOME}/.git-template"
stow talisman
