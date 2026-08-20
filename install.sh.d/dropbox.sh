#!/bin/bash -e
# DEPENDS: wget

# The client updates itself once installed, so this ageing package only ever
# serves as a starting point
package=dropbox_2020.03.04_amd64.deb

if [ "$(uname -s)" == "Linux" ]; then
    if ! dpkg -s dropbox >/dev/null 2>&1; then
        wget "https://www.dropbox.com/download?dl=packages/ubuntu/${package}" -O "/tmp/${package}"
        sudo apt install --yes "/tmp/${package}" python3-gpg
        rm -f "/tmp/${package}"
    fi
fi
