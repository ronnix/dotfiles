# Git man
function mg {
    man git-$1
}

# Hub
if [ -f /usr/local/bin/hub ]; then
    eval "$(hub alias -s)"
fi
