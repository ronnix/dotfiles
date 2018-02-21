if [ "$(uname -s)" == "Darwin" ]; then
    brew install fzf
    stow fzf
fi
