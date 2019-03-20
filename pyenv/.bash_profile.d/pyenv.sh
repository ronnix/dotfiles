if which pyenv >/dev/null; then
    export PYENV_ROOT=~/.pyenv
    eval "$(pyenv init -)"
fi
