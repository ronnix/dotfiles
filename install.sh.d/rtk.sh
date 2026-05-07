#!/bin/bash -e
# DEPENDS: curl claude-code

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions rtk >/dev/null ; then
        brew install rtk
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! command -v rtk >/dev/null ; then
        curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
    fi
fi

# Install global hook for Claude Code (idempotent, backs up settings.json).
PATH="$HOME/.local/bin:$PATH" rtk init -g --auto-patch
