#!/bin/bash -e
# DEPENDS: brew

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions llama.cpp >/dev/null; then
        brew install llama.cpp
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s llama.cpp >/dev/null 2>&1; then
        sudo apt-get install -y llama.cpp
    fi
fi
