# Colored output
alias ls='ls -G'
alias ll='ls -lhG'
alias diff='colordiff'

# Linux-isms
alias ldd="otool -L"
alias rehash="set +h"

# Explain a shell command
explain() {
    open "http://explainshell.com/explain?cmd=$*"
}
