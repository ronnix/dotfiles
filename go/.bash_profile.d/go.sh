export GOPATH=~/dev/go
mkdir -p "$GOPATH/bin"

if [ -d "/usr/lib/go-1.10/bin" ]; then
	pathappend "/usr/lib/go-1.10/bin"
fi

pathappend "$GOPATH/bin"
