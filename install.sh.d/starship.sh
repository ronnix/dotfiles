#!/bin/bash -e
# DEPENDS: brew

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions starship >/dev/null ; then
        brew install starship
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s stow >/dev/null ; then
        sudo apt-get install stow
    fi
fi

# Ajoute la police Meslo (Nerd Font)
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

# Installe la configuration
stow starship
