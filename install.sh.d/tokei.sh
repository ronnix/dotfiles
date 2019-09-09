if [ "$(uname -s)" == "Darwin" ]; then
    brew install tokei
elif [ "$(uname -s)" == "Linux" ]; then
    if [ ! -f /usr/local/bin/tokei ]; then
        wget https://github.com/XAMPPRocky/tokei/releases/download/v10.0.1/tokei-v10.0.1-x86_64-unknown-linux-gnu.tar.gz -O /tmp/tokei-v10.0.1-x86_64-unknown-linux-gnu.tar.gz
        tar xzf /tmp/tokei-v10.0.1-x86_64-unknown-linux-gnu.tar.gz -C /tmp
        sudo cp /tmp/tokei /usr/local/bin/tokei
        rm /tmp/tokei-v10.0.1-x86_64-unknown-linux-gnu.tar.gz /tmp/tokei
    fi
fi
