if hash brew 2>/dev/null; then
  if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    . "$(brew --prefix)/etc/bash_completion"
  fi
fi

export USER_BASH_COMPLETION_DIR=~/.bash_completion.d
