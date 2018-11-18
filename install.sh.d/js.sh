#!/bin/bash -e

# See: https://yarnpkg.com/en/docs/install

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions node >/dev/null ; then
        brew install node
    fi
    if ! brew ls --versions yarn >/dev/null ; then
        brew install yarn
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install --yes yarn
fi

# Prettier code formatter (https://prettier.io)
npm install --global prettier
