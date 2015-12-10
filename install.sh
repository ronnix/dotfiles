set -e

USER=$(whoami)


##
## OS X settings and tweaks
##

source osx-settings.sh


##
## Install apps using Homebrew
##

# Install XCode command-line utilities
if ! xcode-select -p >/dev/null ; then
    xcode-select --install
fi

# Install Homebrew
if [ ! -x /usr/local/bin/brew ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Brew Cask options
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
sudo mkdir -p /opt/homebrew-cask/Caskroom
sudo chown $USER: /opt/homebrew-cask/Caskroom

# Install from Brewfile
brew tap homebrew/bundle
brew update
brew bundle


##
## Manage dotfiles with GNU Stow
##

stow bash
stow git
stow pyenv
stow virtualenvwrapper
stow sublime


##
## Extra configuration using Saltstack
##

# Install Salt
pip install -U salt

# Configure Salt (masterless)
sudo mkdir -p /etc/salt /var/log/salt
cat <<EOF | sudo tee /etc/salt/minion
file_client: local
file_roots:
  base:
    - /Users/$USER/dotfiles/salt-states
EOF

# Run Salt
sudo salt-call --local state.highstate
