#!/bin/bash -e

#
# Install pyenv
#
if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions readline >/dev/null ; then
        brew install readline
    fi
    if ! brew ls --versions xz >/dev/null ; then
        brew install xz
    fi
    if ! brew ls --versions pyenv >/dev/null ; then
        brew install pyenv
    fi
    if ! brew ls --versions pyenv-virtualenv >/dev/null ; then
        brew install pyenv-virtualenv
    fi
    if ! brew ls --versions pyenv-virtualenvwrapper >/dev/null ; then
        brew install pyenv-virtualenvwrapper
    fi
fi

#
# Install config files
#
stow pip
stow pipx
stow pyenv
stow python
stow virtualenvwrapper

if which pyenv ; then

    source ~/.bash_profile.d/pyenv.sh

    # MacOS
    if [ "$(uname -s)" == "Darwin" ]; then

        # Make sure XCode command-line tools are up-to-date
        # see: https://github.com/pyenv/pyenv/issues/530
        xcode-select --install 2>/dev/null || true

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
    VERSIONS="3.7.2 3.6.8 2.7.15"
    for version in $VERSIONS; do
        pyenv install --skip-existing $version
    done
    pyenv global $VERSIONS

fi

#
# Upgrade pip
#
python3.7 -m pip install --upgrade pip

#
# Install pipx
#
python3.7 -m pip install pipx

#
# Install some tools system-wide with pipx
#
export PATH=$HOME/.local/bin:$PATH
pipx install black[d]
pipx install flake8
pipx install isort
pipx install mypy
pipx install pylint
pipx install tox
pipx install virtualenvwrapper
