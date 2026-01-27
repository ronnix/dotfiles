#!/bin/bash -e

if [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s gdebi >/dev/null ; then
        sudo apt-get update
        sudo apt-get install --yes gdebi
    fi
fi
