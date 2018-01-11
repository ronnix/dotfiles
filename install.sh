set -e

#
# Run platform-specific script
#
PLATFORM=$(uname -s)

case $PLATFORM in
  Linux)
    ./install-linux.sh
    ;;
  Darwin)
    ./install-macos.sh
    ;;
esac


#
# Install multiple Python versions with pyenv
#
VERSIONS="2.7.14 3.6.3"
for version in $VERSIONS; do
    CFLAGS="-I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include" \
    LDFLAGS="-L$(brew --prefix openssl)/lib" \
    pyenv install --skip-existing $version
done
pyenv global $VERSIONS


#
# Rename existing .bashrc to avoid conflicts
#
if [ -f ~/.bashrc ]; then
  mv --backup=numbered ~/.bashrc ~/.bashrc.orig
fi


#
# Manage dotfiles with GNU Stow
#
stow ack
stow bash
stow git
stow go
stow pip
stow pyenv
stow python
stow virtualenvwrapper
stow sublime


#
# Reload configuration
#
source $HOME/.bash_profile


#
# Install Go packages
#
go get github.com/golang/lint/golint
go get golang.org/x/tools/cmd/godoc
go get golang.org/x/tools/cmd/goimports
go get golang.org/x/tools/cmd/oracle
go get golang.org/x/tools/cmd/vet
