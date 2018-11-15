if hash brew 2>/dev/null; then
  if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    . "$(brew --prefix)/etc/bash_completion"
  fi
fi

export USER_BASH_COMPLETION_DIR=~/.bash_completion.d
if [[ -d $USER_BASH_COMPLETION_DIR ]]; then
    for i in $(LC_ALL=C command ls "$USER_BASH_COMPLETION_DIR"); do
        i=$USER_BASH_COMPLETION_DIR/$i
        [[ ${i##*/} != @(*~|*.bak|*.swp|\#*\#|*.dpkg*|*.rpm@(orig|new|save)|Makefile*) \
            && -f $i && -r $i ]] && . "$i"
    done
fi
