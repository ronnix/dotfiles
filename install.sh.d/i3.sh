set -o errexit

if [ "$(uname -s)" == "Linux" ]; then
    # Use the latest official i3 packages
    # cf. https://i3wm.org/docs/repositories.html
    /usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
    sudo apt install ./keyring.deb
    echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list

    sudo apt-get update
    sudo apt-get install --yes \
        dmenu \
        i3 \
        i3blocks \
        i3lock \
        i3lock-fancy \
        i3status \
        libanyevent-i3-perl \
        policykit-1-gnome \
        policykit-desktop-privileges \
        rofi

    # Install newer rofi
    #wget https://launchpad.net/ubuntu/+archive/primary/+files/rofi_1.5.4-1_amd64.deb
    #sudo apt install --yes ./rofi_1.5.4-1_amd64.deb
    #rm -f ./rofi_1.5.4-1_amd64.deb

    # Install rofimoji
    VERSION=4.3.0
    if [[ $(rofimoji --version) != "rofimoji $VERSION" ]]; then
        wget https://github.com/fdw/rofimoji/releases/download/$VERSION/rofimoji-$VERSION-py3-none-any.whl
        pipx install rofimoji-$VERSION-py3-none-any.whl
        rm -f ./rofimoji-$VERSION-py3-none-any.whl
    fi

    # Install picom compositing manager
    if [ ! -f /usr/local/bin/picom ]; then
        VERSION=10.2
        wget -O picom.tar.gz https://github.com/yshui/picom/archive/v$VERSION.tar.gz
        tar xzf picom.tar.gz
        rm -rf picom.tar.gz
        pushd picom-$VERSION
        sudo apt install --yes meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev
        meson --buildtype=release . build
        ninja -C build
        sudo ninja -C build install
        popd
        rm -rf picom-$VERSION
    fi

    stow i3
fi
