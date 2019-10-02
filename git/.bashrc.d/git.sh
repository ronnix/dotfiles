# Git man
function mg {
    man git-$1
}

# Hub
if which >/dev/null hub ; then
    eval "$(hub alias -s)"
fi

# Lab
# if [ -f /usr/local/bin/lab ]; then
#     alias git=lab
# fi

# git-absorb
pathprepend $HOME/.cargo/bin
