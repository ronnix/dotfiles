#!/bin/bash -e
# DEPENDS: python

# Frogmouth 0.9.2 is incompatible with Python 3.14 (httpcore typing issue).
pipx install --python "$(pyenv which python3.13)" frogmouth
