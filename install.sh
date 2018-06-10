#!/bin/bash -e

#
# Run platform-specific script
#
case $(uname -s) in
  Linux)
    pushd linux >/dev/null
    ;;
  Darwin)
    pushd macos >/dev/null
    ;;
esac
./install.sh
popd >/dev/null


#
# Extra install steps
#
for script in install.sh.d/*.sh; do
  echo "${script}"
  "${script}"
done
