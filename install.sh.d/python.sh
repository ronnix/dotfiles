#!/bin/bash -e
# DEPENDS: pyenv stow xcode

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

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
MINOR_VERSIONS="3.14 3.13 3.12 3.11 3.10"
VERSIONS=""
for MINOR_VERSION in $MINOR_VERSIONS; do
    VERSION="$(pyenv latest --known $MINOR_VERSION)"
    VERSIONS+="$VERSION "
    pyenv install --skip-existing $VERSION
done
pyenv global $VERSIONS
pyenv rehash

#
# Bootstrap pip and pipx. They only move forward under --update: upgrading them
# on every run is what the install-or-update convention rules out.
#
if needs_install command -v pipx; then
    python3 -m pip install --upgrade pip
    python3 -m pip install pipx
fi

#
# Install some tools system-wide with pipx
#
export PATH=$HOME/.local/bin:$PATH
for PKG in "black[d]" flake8 isort mypy tox virtualenv virtualenvwrapper; do
    # pipx names the venv after the package, without the extras
    if needs_install test -d "$HOME/.local/pipx/venvs/${PKG%%\[*}"; then
        # --force, so that --update reinstalls: a plain `pipx install` leaves an
        # existing venv alone and still exits 0
        python3 -m pipx install --force "$PKG"
    fi
done

#
# Install config files
#
stow pip
stow pipx
stow python
stow virtualenvwrapper
