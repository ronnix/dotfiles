#!/bin/bash -e

# Install Sublime Text
if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew cask ls --versions sublime-text >/dev/null ; then
        brew cask install sublime-text
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    sudo apt-get update
    sudo apt install --yes software-properties-common wget
    sudo add-apt-repository --yes "deb https://download.sublimetext.com/ apt/stable/"
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install sublime-text
fi

# Setup config files
if [[ $(uname -s) == "Darwin" ]]; then
    pushd sublime
    mkdir -p "Library/Application Support/"
    if [ ! -L "Sublime Text 3" ]; then
        ln -s .config/sublime-text-3 "Library/Application Support/Sublime Text 3"
    fi
    popd
fi
stow -vv sublime

# Install Package Control
if [ "$(uname -s)" == "Darwin" ]; then
    CONFIG_DIR="${HOME}/Library/Application Support/Sublime Text 3"
else
    CONFIG_DIR="${HOME}/.config/sublime-text-3"
fi
PACKAGE_CONTROL="${CONFIG_DIR}/Installed Packages/Package Control.sublime-package"
if [ ! -f "$PACKAGE_CONTROL" ]; then
    curl "https://packagecontrol.io/Package%20Control.sublime-package" -o "$PACKAGE_CONTROL"
fi

# Add symbolic link on macOS
if [[ $(uname -s) == "Darwin" ]]; then
    if [ ! -L /usr/local/bin/subl ]; then
        ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
    fi
fi
