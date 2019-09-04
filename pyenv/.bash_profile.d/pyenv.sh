export PYENV_ROOT=~/.pyenv

if [ -d $PYENV_ROOT/shims ]; then
    export PATH="$PYENV_ROOT/shims:$PATH"
fi
if [ -d $PYENV_ROOT/bin ]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
fi
if which pyenv >/dev/null; then
    eval "$(pyenv init -)"
fi
