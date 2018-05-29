# Colored output
alias ls='ls -G'
alias ll='ls -lhG'
alias diff='colordiff'

# Linux-isms
if [ "$(uname -s)" == "Darwin" ]; then
  alias ldd="otool -L"
  alias rehash="set +h"
fi

# Explain a shell command
explain () {
    open "http://explainshell.com/explain?cmd=$*"
}

# Combined mkdir + cd
mkcd ()
{
    mkdir -p -- "$1" && cd -P -- "$1" || return
}
