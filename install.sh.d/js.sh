#!/bin/bash -e

# 1) Install node
if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions node >/dev/null ; then
        brew install node
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # See: https://github.com/nodesource/distributions#debinstall
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt-get update
    sudo apt-get remove --yes npm
    sudo apt-get install --yes nodejs
fi

# Tell NPM to install global packages in my home
mkdir -p ~/.npm-packages
npm config set prefix ~/.npm-packages
echo prefix=${HOME}/.npm-packages >>~/.npmrc

# Install config files
stow js

# 2) Install yarn
# See: https://yarnpkg.com/en/docs/install

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions yarn >/dev/null ; then
        brew install yarn
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install --yes yarn
fi

# 3) Prettier code formatter (https://prettier.io)
CMD="npm install --global prettier"
if [ "$(uname -s)" == "Darwin" ]; then
    $CMD
elif [ "$(uname -s)" == "Linux" ]; then
    sudo $CMD
fi
