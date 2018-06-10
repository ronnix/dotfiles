if [ "$(uname -s)" == "Linux" ]; then

    VERSION=2.4.0

    if [ ! -f "/usr/local/bin/hub" -o "$(hub --version | grep hub | cut -d\  -f3)" != "$VERSION" ]; then
        pushd /tmp >/dev/null
        rm -rf hub-linux-amd64-$VERSION hub-linux-amd64-$VERSION.tgz
        wget https://github.com/github/hub/releases/download/v$VERSION/hub-linux-amd64-$VERSION.tgz
        tar xzf hub-linux-amd64-$VERSION.tgz
        sudo ./hub-linux-amd64-$VERSION/install
        rm -rf hub-linux-amd64-$VERSION hub-linux-amd64-$VERSION.tgz
        popd >/dev/null
    fi
fi
