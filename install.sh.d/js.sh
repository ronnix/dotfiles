# See: https://yarnpkg.com/en/docs/install

if [ "$(uname -s)" == "Darwin" ]; then
    brew install node
    brew install yarn
elif [ "$(uname -s)" == "Linux" ]; then
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install --yes yarn
fi
