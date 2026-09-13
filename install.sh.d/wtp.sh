#!/bin/bash -e
# DEPENDS: brew stow

# cf. https://github.com/satococoa/wtp
# and https://dev.to/satococoa/wtp-a-better-git-worktree-cli-tool-4i8l

if [ "$(uname -s)" == "Darwin" ]; then
    brew trust --formula satococoa/tap/wtp
    if ! brew ls --versions wtp >/dev/null; then
        brew install satococoa/tap/wtp
    fi
fi

stow wtp
