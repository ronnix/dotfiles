#!/bin/bash -e
# DEPENDS: cargo curl git stow wget

VERSION=0.14.0

# Alacritty has no Ubuntu package worth using, so build it from source. macOS is
# deliberately left out: `brew install --cask alacritty` covers it the day the
# need comes back, and this block would otherwise compile Alacritty on every run
# before failing on the Linux-shaped install steps below.
if [ "$(uname -s)" == "Linux" ] && ! command -v alacritty >/dev/null; then
    rm -f alacritty.tar.gz
    wget https://github.com/alacritty/alacritty/archive/refs/tags/v$VERSION.tar.gz -O alacritty.tar.gz
    tar xzf alacritty.tar.gz
    rm -f alacritty.tar.gz

    pushd alacritty-$VERSION

    # Build dependencies
    if ! dpkg -s cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 >/dev/null; then
        sudo apt update
        sudo apt install --yes cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
    fi

    cargo build --release

    sudo cp target/release/alacritty /usr/local/bin/alacritty
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install extra/linux/Alacritty.desktop
    sudo update-desktop-database

    popd

    rm -rf alacritty-$VERSION
fi

if [[ -d $HOME/local/src/alacritty-theme ]]; then
    pushd $HOME/local/src/alacritty-theme
    git pull
    popd
else
    git clone https://github.com/alacritty/alacritty-theme $HOME/local/src/alacritty-theme
fi

stow alacritty
