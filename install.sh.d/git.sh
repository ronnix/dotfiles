#!/bin/bash -e

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions git >/dev/null ; then
        brew install git
    fi
    if ! brew ls --versions zaquestion/tap/lab >/dev/null ; then
        brew install zaquestion/tap/lab
    fi
    if ! [ -f $HOME/.cargo/bin/git-absorb ]; then
        sudo apt install --assume-yes cargo
        cargo install git-absorb
    fi
fi

if [ "$(uname -s)" == "Linux" ]; then
    sudo apt-get install --yes exiftool imagemagick xdg-utils
fi

stow git

# Install git-diff-image
SHA1=12e717f5e9b084e117c354db5204b949b3232a95
DEST=~/.local/bin
wget https://raw.githubusercontent.com/ewanmellor/git-diff-image/${SHA1}/diff-image -O ${DEST}/diff-image
wget https://raw.githubusercontent.com/ewanmellor/git-diff-image/${SHA1}/git_diff_image -O ${DEST}/git_diff_image
