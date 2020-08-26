#!/bin/bash -e

# Install APT packages
sudo apt-get update
sudo apt-get install --yes $(egrep -v '^(#|$)' apt-packages-list.txt)

# Linux-specific config
stow --dir=.. --target=${HOME} xclip
