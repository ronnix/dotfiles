#!/bin/bash -e

VERSION=0.12.2

rm -f alacritty.tar.gz
wget https://github.com/alacritty/alacritty/archive/refs/tags/v$VERSION.tar.gz -O alacritty.tar.gz
tar xzf alacritty.tar.gz
rm -f alacritty.tar.gz

pushd alacritty-$VERSION

# On installe le compilateur Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# On s’assure qu’on a la dernière version
rustup override set stable
rustup update stable

# On installe les dépendances
sudo apt update
sudo apt install --yes cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

# On compile
cargo build --release

# On installe
sudo cp target/release/alacritty /usr/local/bin/alacritty
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

popd

rm -rf alacritty-$VERSION
