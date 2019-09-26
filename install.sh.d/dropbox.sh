if [ "$(uname -s)" == "Linux" ]; then
    wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2019.02.14_amd64.deb -O /tmp/dropbox_2019.02.14_amd64.deb
    sudo apt install --yes /tmp/dropbox_2019.02.14_amd64.deb python3-gpg
    rm -f /tmp/dropbox_2019.02.14_amd64.deb
fi
