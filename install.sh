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
stow pip
stow pyenv
stow python
stow virtualenvwrapper
stow sublime
