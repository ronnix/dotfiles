#!/bin/bash -e

# Add unofficial Sublime Text 3 installer APT repo
sudo apt-get update
sudo apt install --yes software-properties-common
sudo add-apt-repository --yes ppa:webupd8team/sublime-text-3

# Install APT packages
sudo apt-get update
sudo apt-get install --yes $(egrep -v '^(#|$)' apt-packages-list.txt)

# Install hub

VERSION=2.4.0
pushd /tmp >/dev/null
rm -rf hub-linux-amd64-$VERSION hub-linux-amd64-$VERSION.tgz
wget https://github.com/github/hub/releases/download/v$VERSION/hub-linux-amd64-$VERSION.tgz
tar xzf hub-linux-amd64-$VERSION.tgz
sudo ./hub-linux-amd64-$VERSION/install
rm -rf hub-linux-amd64-$VERSION hub-linux-amd64-$VERSION.tgz
popd >/dev/null
