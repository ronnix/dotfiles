#
# Install and run bash profile fragment
#
stow go
source ~/.bash_profile.d/go.sh

#
# Install some useful Go packages
#
go get github.com/golang/lint/golint
go get golang.org/x/tools/cmd/godoc
go get golang.org/x/tools/cmd/goimports
go get golang.org/x/tools/cmd/oracle
go get golang.org/x/tools/cmd/vet
