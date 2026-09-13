#!/bin/bash -e
# DEPENDS: brew llama-cpp

if [ "$(uname -s)" == "Darwin" ]; then
    brew trust --formula mostlygeek/llama-swap/llama-swap
    if ! brew ls --versions llama-swap >/dev/null; then
        brew install mostlygeek/llama-swap/llama-swap
    fi
fi
