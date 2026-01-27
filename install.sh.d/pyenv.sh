#!/bin/bash -e
# DEPENDS: curl git stow wget

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
elif [ "$(uname -s)" == "Linux" ]; then
    sudo apt-get update
    sudo apt-get install --yes --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    if ! [ -d ~/.pyenv ]; then
        git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    fi
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"
fi

#
# Install config files
#
stow pyenv
