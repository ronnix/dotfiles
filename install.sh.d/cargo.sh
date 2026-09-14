#!/bin/bash -e
# DEPENDS: curl stow

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

# Install using rustup
if needs_install test -f "$HOME/.cargo/bin/cargo"; then
    if [ -x "$HOME/.cargo/bin/rustup" ]; then
        # Already installed and --update asked for a refresh. rustup-init
        # refuses to run over an existing installation, so use rustup itself.
        "$HOME/.cargo/bin/rustup" update stable
    else
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -- -y
    fi
fi

# Install config files
stow cargo

# Load environment variables
source "$HOME/.bashrc.d/cargo.sh"

rustup override set stable
