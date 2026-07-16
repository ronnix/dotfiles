#!/bin/bash -e
# DEPENDS: curl

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions clever-tools >/dev/null; then
        brew install CleverCloud/homebrew-tap/clever-tools
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! command -v clever >/dev/null; then
        curl -fsSL https://clever-tools.clever-cloud.com/gpg/cc-nexus-deb.public.gpg.key |
            sudo gpg --dearmor -o /usr/share/keyrings/cc-nexus-deb.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/cc-nexus-deb.gpg] https://nexus.clever-cloud.com/repository/deb stable main" |
            sudo tee /etc/apt/sources.list.d/clever-tools.list >/dev/null
        sudo apt-get update
        sudo apt-get install -y clever-tools
    fi
fi
