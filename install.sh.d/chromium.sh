if [ "$(uname -s)" == "Linux" ]; then
    cat <<EOF | sudo tee >/dev/null /etc/apt/preferences.d/chromium
Package: *
Pin: release o=LP-PPA-saiarcot895-chromium-beta
Pin-Priority: 800
EOF

    sudo add-apt-repository --yes ppa:saiarcot895/chromium-beta
    sudo apt update
    sudo apt install --yes chromium-browser chromium-chromedriver
fi
