if [ "$(uname -s)" == "Linux" ]; then
    curl --remote-name https://www.rescuetime.com/installers/rescuetime_current_amd64.deb
    sudo gdebi --non-interactive ./rescuetime_current_amd64.deb
    rm -f rescuetime_current_amd64.deb
fi
