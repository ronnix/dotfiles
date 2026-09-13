#!/bin/bash -e
# DEPENDS: brew curl

if [ "$(uname -s)" == "Darwin" ]; then
    brew trust --formula dart-lang/dart/dart
    if ! brew ls --versions dart >/dev/null; then
        brew install dart-lang/dart/dart
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # Official Google apt repository (amd64 only), cf. https://dart.dev/get-dart
    if ! dpkg -s dart >/dev/null 2>&1; then
        curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub |
            sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg
        echo "deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main" |
            sudo tee /etc/apt/sources.list.d/dart_stable.list >/dev/null
        sudo apt-get update
        sudo apt-get install -y dart
    fi
fi
