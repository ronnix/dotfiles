#
# Rename existing .bashrc to avoid conflicts
#
if [ -f ~/.bashrc ]; then
  if [ -x /usr/local/bin/gmv ]; then
    MV=gmv
  else
    MV=mv
  fi
  $MV --backup=numbered ~/.bashrc ~/.bashrc.orig
fi

stow bash
