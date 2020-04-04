if [ "$(uname -s)" == "Linux" ]; then
    sudo add-apt-repository --yes ppa:mmstick76/alacritty
    sudo apt-get update
    sudo apt-get install --yes alacritty
    stow alacritty
fi
