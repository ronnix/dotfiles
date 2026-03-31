#!/bin/bash -e
# DEPENDS: brew

if [ "$(uname -s)" == "Darwin" ]; then
    brew install --cask lm-studio
    ln -sf "/Applications/LM Studio.app/Contents/Resources/app/.webpack/lms" "$HOME/.local/bin/lms"
fi

stow lm-studio
