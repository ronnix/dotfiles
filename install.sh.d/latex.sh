#!/bin/bash -e
# DEPENDS: brew

if [ "$(uname -s)" == "Darwin" ]; then
    if ! command -v pdflatex >/dev/null ; then
        brew install --cask basictex
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s texlive >/dev/null ; then
        sudo apt-get install texlive
    fi
fi
