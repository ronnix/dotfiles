#!/bin/bash -e
# DEPENDS: brew

if ! command -v dolt >/dev/null ; then
    brew install dolt
fi
