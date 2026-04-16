#!/bin/bash -e
# DEPENDS: brew llama-cpp

if [ "$(uname -s)" == "Darwin" ]; then
    brew tap mostlygeek/llama-swap
    brew install llama-swap
fi
