#!/bin/bash -e

#
# Run platform-specific script
#
case $(uname -s) in
  Linux)
    pushd linux
    ;;
  Darwin)
    pushd macos
    ;;
esac
./install.sh
popd


#
# Extra install steps
#
for script in install.sh.d/*.sh; do
  echo "${script}"
  "${script}"
done
