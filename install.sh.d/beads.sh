#!/bin/bash -e
# DEPENDS: go

if ! command -v bd >/dev/null ; then
    go install github.com/steveyegge/beads/cmd/bd@latest
fi
