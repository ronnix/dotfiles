#!/bin/bash -e

#
# Install pyenv
#
if [ "$(uname -s)" == "Darwin" ]; then
    brew install readline openssl xz pyenv pyenv-virtualenv pyenv-virtualenvwrapper
fi

#
# Install config files
#
stow pip
stow pyenv
stow python
stow virtualenvwrapper

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
python3.6 -m pip install --upgrade black
python3.6 -m pip install --upgrade flake8
python3.6 -m pip install --upgrade mypy
python3.6 -m pip install --upgrade pylint
python3.6 -m pip install --upgrade tox
