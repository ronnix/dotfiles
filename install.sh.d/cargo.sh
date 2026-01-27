#!/bin/bash -e
# DEPENDS: curl stow

# Install using rustup
if ! [ -f $HOME/.cargo/bin/cargo ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -- -y
fi

# Install config files
stow cargo

# Load environment variables
source $HOME/.bashrc.d/cargo.sh

# Make sure we have the latest version
rustup override set stable
rustup update stable
