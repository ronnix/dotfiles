#!/bin/bash -e
# DEPENDS: brew stow

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew list --cask --versions lm-studio >/dev/null; then
        brew install --cask lm-studio
        # The CLI ships inside the app bundle
        mkdir -p "$HOME/.local/bin"
        ln -sf "/Applications/LM Studio.app/Contents/Resources/app/.webpack/lms" "$HOME/.local/bin/lms"
    fi
fi

stow lm-studio
