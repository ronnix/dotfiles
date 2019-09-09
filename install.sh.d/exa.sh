if [ "$(uname -s)" == "Darwin" ]; then
    brew install exa
elif [ "$(uname -s)" == "Linux" ]; then
    if [ ! -f /usr/local/bin/exa ]; then
        wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip -O /tmp/exa-linux-x86_64-0.9.0.zip
        unzip -o /tmp/exa-linux-x86_64-0.9.0.zip -d /tmp
        sudo cp /tmp/exa-linux-x86_64 /usr/local/bin/exa
        rm /tmp/exa-linux-x86_64-0.9.0.zip /tmp/exa-linux-x86_64
    fi
fi
