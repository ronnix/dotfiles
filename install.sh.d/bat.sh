if [ "$(uname -s)" == "Darwin" ]; then
    brew install bat
elif [ "$(uname -s)" == "Linux" ]; then
    wget https://github.com/sharkdp/bat/releases/download/v0.12.1/bat_0.12.1_amd64.deb -O /tmp/bat_0.12.1_amd64.deb
    sudo apt-get install gdebi
    sudo gdebi -n /tmp/bat_0.12.1_amd64.deb
    rm /tmp/bat_0.12.1_amd64.deb
fi
