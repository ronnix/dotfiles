package=dropbox_2020.03.04_amd64.deb

if [ "$(uname -s)" == "Linux" ]; then
    wget https://www.dropbox.com/download?dl=packages/ubuntu/${package} -O /tmp/${package}
    sudo apt install --yes /tmp/${package} python3-gpg
    rm -f /tmp/${package}
fi
