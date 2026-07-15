#!/bin/bash -e
# DEPENDS: brew curl

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions sentry-cli >/dev/null; then
        brew install getsentry/tools/sentry-cli
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # No apt repository, use the official install script from Sentry
    if ! command -v sentry-cli >/dev/null; then
        curl -fsSL https://sentry.io/get-cli/ | INSTALL_DIR="$HOME/.local/bin" bash
    fi
fi
