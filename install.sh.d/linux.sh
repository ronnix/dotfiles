#!/bin/bash -e
# DEPENDS: stow

# Linux-specific config
stow --dir=. --target=${HOME} xclip
