#!/bin/bash -e
# DEPENDS: cargo curl git stow wget

VERSION=0.14.0

rm -f alacritty.tar.gz
wget https://github.com/alacritty/alacritty/archive/refs/tags/v$VERSION.tar.gz -O alacritty.tar.gz
tar xzf alacritty.tar.gz
rm -f alacritty.tar.gz

pushd alacritty-$VERSION

# On installe les dépendances
if [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 >/dev/null ; then
        sudo apt update
        sudo apt install --yes cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
    fi
fi

# On compile
cargo build --release

# On installe
sudo cp target/release/alacritty /usr/local/bin/alacritty
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
if [ "$(uname -s)" == "Linux" ]; then
    sudo desktop-file-install extra/linux/Alacritty.desktop
    sudo update-desktop-database
fi

popd

rm -rf alacritty-$VERSION

if [[ -d $HOME/local/src/alacritty-theme ]]; then
    pushd $HOME/local/src/alacritty-theme
    git pull
    popd
else
    git clone https://github.com/alacritty/alacritty-theme $HOME/local/src/alacritty-theme
fi

stow alacritty
