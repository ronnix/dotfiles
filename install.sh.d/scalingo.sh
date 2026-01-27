#!/bin/bash -e
# DEPENDS: curl stow

curl -O https://cli-dl.scalingo.com/install && bash install

stow scalingo

