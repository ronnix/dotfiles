#!/bin/bash -e
# DEPENDS: bun stow

bun install -g critique

stow critique
