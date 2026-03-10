#!/bin/bash -e
# DEPENDS: stow bash brew

#
# Install Go
#
if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions go >/dev/null ; then
        brew install go
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    if ! command -v go >/dev/null ; then
        sudo apt-get install -y golang
    fi
fi

#
# Install and run bash profile fragment
#
stow go
source ~/.bash_functions
source ~/.bash_profile.d/go.sh

#
# Install some useful Go tools
#
go install golang.org/x/lint/golint@latest
go install golang.org/x/tools/cmd/godoc@latest
go install golang.org/x/tools/cmd/goimports@latest
go install golang.org/x/tools/cmd/guru@latest
