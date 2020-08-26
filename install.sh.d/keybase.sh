if [ "$(uname -s)" == "Linux" ]; then
    curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
    sudo gdebi --non-interactive ./keybase_amd64.deb
    rm -f keybase_amd64.deb
fi
