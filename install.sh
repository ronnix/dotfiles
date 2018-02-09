set -o errexit

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
source ./install.sh
popd


#
# Extra install steps
#
for script in install.sh.d/*.sh; do
  echo ${script}
  source ${script}
done
