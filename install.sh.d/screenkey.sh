#!/bin/bash -e
# DEPENDS: wget

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

if [ "$(uname -s)" == "Linux" ]; then
    # Built from the author's tarball: screenkey is not in the Ubuntu archive
    if needs_install command -v screenkey; then
        wget https://www.thregr.org/~wavexx/software/screenkey/releases/screenkey-1.2.tar.gz
        tar xzf screenkey-1.2.tar.gz
        rm screenkey-1.2.tar.gz
        pushd screenkey-1.2/
        sudo apt-get install python3-gi gir1.2-gtk-3.0 python3-cairo python3-setuptools python3-distutils-extra fonts-font-awesome slop
        /usr/bin/python3 ./setup.py bdist_egg
        sudo /usr/bin/python3 ./setup.py install
        popd
        rm -rf screenkey-1.2
    fi
fi
