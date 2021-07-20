# Colored output

alias diff='colordiff'

if [ "$(uname -s)" == "Darwin" ]; then
  alias ls='ls -G'
  alias ll='ls -lhG'

  alias ldd="otool -L"
  alias rehash="set +h"
else
  alias ls='ls --color=auto'
  alias ll='ls --color=auto -lh'
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

# Add all SSH keys
alias ssh-add-all='find ~/.ssh -name 'id_rsa*' | egrep -v ".pub$" | xargs ssh-add'
