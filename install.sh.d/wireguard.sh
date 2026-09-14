#!/bin/bash -e

if [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s wireguard >/dev/null 2>&1; then
        sudo add-apt-repository --yes ppa:wireguard/wireguard
        sudo apt-get update
        sudo apt-get install --yes wireguard resolvconf
    fi
fi
