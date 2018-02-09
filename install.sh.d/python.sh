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
VERSIONS="2.7.14 3.6.4"
for version in $VERSIONS; do
    CFLAGS="-I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include" \
    LDFLAGS="-L$(brew --prefix openssl)/lib" \
    pyenv install --skip-existing $version
done
pyenv global $VERSIONS

python3.6 -m pip install --upgrade flake8
python3.6 -m pip install --upgrade tox
# python3.6 -m pip install --upgrade mypy-lang
