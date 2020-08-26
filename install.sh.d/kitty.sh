set -o errexit

if [ "$(uname -s)" == "Linux" ]; then
    version=0.18.3
    install_dir=$HOME/.local/kitty.app

    mkdir -p $install_dir
    wget https://github.com/kovidgoyal/kitty/releases/download/v${version}/kitty-${version}-x86_64.txz -Okitty-${version}.txz
    tar xJf kitty-${version}.txz --directory=$install_dir
    rm -f kitty-${version}.txz
    stow kitty
fi
