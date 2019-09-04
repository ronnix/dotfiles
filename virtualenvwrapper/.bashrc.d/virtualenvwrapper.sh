#!/bin/bash
if [ -f "$HOME/.local/bin/virtualenvwrapper.sh" ] ; then
    export VIRTUALENVWRAPPER_PYTHON=$HOME/.local/pipx/venvs/virtualenvwrapper/bin/python
    source "$HOME/.local/bin/virtualenvwrapper.sh"
fi
