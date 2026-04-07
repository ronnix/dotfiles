#!/bin/bash -e
# DEPENDS: brew

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions font-meslo-lg-nerd-font >/dev/null ; then
        brew install --cask font-meslo-lg-nerd-font
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip
    unzip Meslo.zip
    fc-cache -fv
fi
