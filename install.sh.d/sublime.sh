#!/bin/bash -e

# Install Sublime Text
if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew cask ls --versions sublime-text >/dev/null ; then
        brew cask install sublime-text
    fi
fi

# Install Package Control
if [ "$(uname -s)" == "Darwin" ]; then
    CONFIG_DIR="${HOME}/Library/Application Support/Sublime Text 3"
    PACKAGE_CONTROL="${CONFIG_DIR}/Installed Packages/Package Control.sublime-package"
    if [ ! -f "$PACKAGE_CONTROL" ]; then
        curl "https://packagecontrol.io/Package%20Control.sublime-package" -o "$PACKAGE_CONTROL"
    fi
fi

stow sublime

# Add symbolic link on macOS
if [[ $(uname -s) == 'Darwin' ]]; then
    if [ ! -L /usr/local/bin/subl ]; then
        ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
    fi
fi
