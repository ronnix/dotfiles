#!/bin/bash -e
# DEPENDS: brew git

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

# Extra completion definitions from zsh-users/zsh-completions. The directory
# is added to fpath in zsh/.zshrc.

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions zsh-completions >/dev/null; then
        brew install zsh-completions
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # Not packaged by Debian/Ubuntu, so keep a checkout of the repository
    DIR="${HOME}/.local/share/zsh-completions"
    if needs_install test -d "${DIR}"; then
        if [ -d "${DIR}" ]; then
            git -C "${DIR}" pull -q --ff-only
        else
            git clone -q --depth 1 https://github.com/zsh-users/zsh-completions "${DIR}"
        fi
    fi
fi
