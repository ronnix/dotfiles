#!/bin/bash -e

# cf. https://samtools.github.io/bcftools/howtos/install.html

# Install dependencies
if [ "$(uname -s)" == "Linux" ]; then
    sudo apt-get install --yes autoconf automake make gcc perl zlib1g-dev libbz2-dev liblzma-dev libcurl4-gnutls-dev libssl-dev libperl-dev libgsl0-dev
elif [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions xz >/dev/null ; then
        brew install xz
    fi
    if ! brew ls --versions gsl >/dev/null ; then
        brew install gsl
    fi
fi

# Create temporary directory for build
TEMP_DIR=$(mktemp -d)
echo "Using temporary directory: $TEMP_DIR"

# Cleanup function to remove temp directory on exit
cleanup() {
    echo "Cleaning up temporary directory: $TEMP_DIR"
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

# Change to temp directory
pushd "$TEMP_DIR"

# Install htslib
git clone --recurse-submodules https://github.com/samtools/htslib.git
pushd htslib
make
sudo make install
popd

# Install bcftools
git clone https://github.com/samtools/bcftools.git
pushd bcftools
 # The following is optional:
 #   autoheader && autoconf && ./configure --enable-libgsl --enable-perl-filters
make
sudo make install
popd

popd

stow bcftools
