#!/bin/bash -e
# DEPENDS: brew

if [ "$(uname -s)" == "Darwin" ]; then
    brew install llama.cpp
elif [ "$(uname -s)" == "Linux" ]; then
    sudo apt-get install -y llama.cpp
fi
