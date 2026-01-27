#!/bin/bash -e
# DEPENDS: pyenv stow xcode

source ~/.bashrc.d/pyenv.sh

# MacOS
if [ "$(uname -s)" == "Darwin" ]; then

    # Install missing headers on 10.14 (Mojave)
    # see: https://github.com/pyenv/pyenv/issues/1219
    MAJOR_VERSION=$(sw_vers -productVersion | cut -d '.' -f 1,2)
    if [ "$MAJOR_VERSION" == "10.14" ] && [ ! -f /usr/include/zlib.h ]; then
        sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
    fi

fi

#
# Install multiple Python versions with pyenv
#
MINOR_VERSIONS="3.13 3.12 3.11 3.10 3.9 3.8 3.7 2.7"
VERSIONS=""
for MINOR_VERSION in $MINOR_VERSIONS; do
    VERSION="$(pyenv latest --known $MINOR_VERSION)"
    VERSIONS+="$VERSION "
    pyenv install --skip-existing $VERSION
done
pyenv global $VERSIONS
pyenv rehash

#
# Upgrade pip
#
python3 -m pip install --upgrade pip

#
# Install pipx
#
python3 -m pip install pipx

#
# Install some tools system-wide with pipx
#
export PATH=$HOME/.local/bin:$PATH
python3 -m pipx install black[d]
python3 -m pipx install flake8
python3 -m pipx install isort
python3 -m pipx install mypy
python3 -m pipx install tox
python3 -m pipx install virtualenv
python3 -m pipx install virtualenvwrapper

#
# Install config files
#
stow pip
stow pipx
stow python
stow virtualenvwrapper
