#!/bin/bash -e
# DEPENDS: gdebi wget

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions bat >/dev/null ; then
        brew install bat
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s bat >/dev/null ; then
        wget https://github.com/sharkdp/bat/releases/download/v0.12.1/bat_0.12.1_amd64.deb -O /tmp/bat_0.12.1_amd64.deb
        sudo gdebi --non-interactive /tmp/bat_0.12.1_amd64.deb
        rm /tmp/bat_0.12.1_amd64.deb
    fi
fi
