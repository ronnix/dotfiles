# Colored output
alias ls='ls -G'
alias ll='ls -lhG'
alias diff='colordiff'

# Supervisor
alias sc='supervisorctl'

# Linux-isms
alias ldd="otool -L"
alias rehash="set +h"

# Mercurial
alias cdh='cd `hg root` && pwd'

# Explain a shell command
explain() {
    open "http://explainshell.com/explain?cmd=$*"
}
