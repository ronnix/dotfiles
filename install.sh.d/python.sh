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
stow pyenv
stow python
stow virtualenvwrapper

if which pyenv ; then

    source ~/.bash_profile.d/pyenv.sh

    #
    # Install multiple Python versions with pyenv
    #
    VERSIONS="3.6.5 2.7.14"
    for version in $VERSIONS; do
        pyenv install --skip-existing $version
    done
    pyenv global $VERSIONS

    #
    # Install some tools system-wide
    #
    python3.6 -m pip install --upgrade pip
    python3.6 -m pip install --upgrade black
    python3.6 -m pip install --upgrade flake8
    python3.6 -m pip install --upgrade mypy
    python3.6 -m pip install --upgrade pylint
    python3.6 -m pip install --upgrade tox

fi
