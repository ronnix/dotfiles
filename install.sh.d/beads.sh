#!/bin/bash -e
# DEPENDS: go dolt

if ! command -v bd >/dev/null ; then
    go install github.com/steveyegge/beads/cmd/bd@latest
fi
