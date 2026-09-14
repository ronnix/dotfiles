#!/bin/bash -e

if [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s chromium-browser >/dev/null 2>&1; then
        cat <<PREFS | sudo tee /etc/apt/preferences.d/chromium >/dev/null
Package: *
Pin: release o=LP-PPA-saiarcot895-chromium-beta
Pin-Priority: 800
PREFS

        sudo add-apt-repository --yes ppa:saiarcot895/chromium-beta
        sudo apt update
        sudo apt install --yes chromium-browser chromium-chromedriver
    fi
fi
