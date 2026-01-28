if [ "$(uname -s)" = "Darwin" ]; then
    [ -f "$(brew --prefix)/etc/profile.d/autojump.sh" ] && . "$(brew --prefix)/etc/profile.d/autojump.sh"
elif [ -f /usr/share/autojump/autojump.sh ]; then
    . /usr/share/autojump/autojump.sh
fi
