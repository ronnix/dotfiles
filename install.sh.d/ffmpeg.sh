#!/bin/bash -e
# DEPENDS: brew

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions ffmpeg >/dev/null ; then
        brew install ffmpeg
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s ffmpeg >/dev/null ; then
        sudo apt-get install ffmpeg
    fi
fi
