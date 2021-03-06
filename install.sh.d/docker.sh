if [ "$(uname -s)" == "Linux" ]; then
    sudo apt-get install --yes apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    sudo apt-get update
    sudo apt-get install --yes docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker $USER
fi
