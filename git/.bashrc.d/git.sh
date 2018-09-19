# Git man
function mg {
    man git-$1
}

# Hub
if [ -f /usr/local/bin/hub ]; then
    eval "$(hub alias -s)"
fi

# Lab
# if [ -f /usr/local/bin/lab ]; then
#     alias git=lab
# fi
