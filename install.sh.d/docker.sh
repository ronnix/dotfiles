if [ "$(uname -s)" == "Linux" ]; then
    sudo apt-get update
    sudo apt-get install --yes docker.io docker-compose
    sudo usermod -aG docker $USER
fi
