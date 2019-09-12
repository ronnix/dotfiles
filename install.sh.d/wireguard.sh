if [ "$(uname -s)" == "Linux" ]; then
    sudo add-apt-repository --yes ppa:wireguard/wireguard
    sudo apt-get update
    sudo apt-get install --yes wireguard resolvconf
fi
