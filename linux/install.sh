#!/bin/bash -e

# Install APT packages
sudo apt-get install --yes $(egrep -v '^(#|$)' apt-packages-list.txt)

# Install hub
VERSION=2.3.0-pre10
pushd /tmp
rm -rf hub-linux-amd64-$VERSION hub-linux-amd64-$VERSION.tgz
wget https://github.com/github/hub/releases/download/v$VERSION/hub-linux-amd64-$VERSION.tgz
tar xzf hub-linux-amd64-$VERSION.tgz
sudo ./hub-linux-amd64-$VERSION/install
rm -rf hub-linux-amd64-$VERSION hub-linux-amd64-$VERSION.tgz
popd
