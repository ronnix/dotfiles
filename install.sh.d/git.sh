#!/bin/bash -e
# DEPENDS: cargo stow wget

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions git >/dev/null ; then
        brew install git
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s git >/dev/null ; then
        sudo apt-get update
        sudo apt-get install --yes git
    fi
fi

# Extension git-absorb
if ! [ -f $HOME/.cargo/bin/git-absorb ]; then
    [ -f $HOME/.cargo/bin/cargo install git-absorb
fi

# Extension git-diff-image
if [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s exiftool imagemagick xdg-utils >/dev/null ; then
        sudo apt-get update
        sudo apt-get install --yes exiftool imagemagick xdg-utils
    fi
fi
SHA1=f12098b2b9b9f56f205f8e9ca8435796a0fdc1fc
DEST=~/.local/bin
mkdir -p ${DEST}
wget https://raw.githubusercontent.com/ewanmellor/git-diff-image/${SHA1}/diff-image -O ${DEST}/diff-image
wget https://raw.githubusercontent.com/ewanmellor/git-diff-image/${SHA1}/git_diff_image -O ${DEST}/git_diff_image

# Install config files
stow git
