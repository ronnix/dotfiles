set -o errexit

if [ "$(uname -s)" == "Linux" ]; then
    # Use the latest official i3 packages
    # cf. https://i3wm.org/docs/repositories.html
    /usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2024.03.04_all.deb keyring.deb SHA256:f9bb4340b5ce0ded29b7e014ee9ce788006e9bbfe31e96c09b2118ab91fca734
    sudo apt install ./keyring.deb
    echo "deb http://debian.sur5r.net/i3/ $(grep '^UBUNTU_CODENAME=' /etc/os-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list

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
    VERSION=6.5.0
    if [[ $(rofimoji --version) != "rofimoji $VERSION" ]]; then
        wget https://github.com/fdw/rofimoji/releases/download/$VERSION/rofimoji-$VERSION-py3-none-any.whl
        pipx install rofimoji-$VERSION-py3-none-any.whl
        rm -f ./rofimoji-$VERSION-py3-none-any.whl
    fi

    # Install picom compositing manager
    if [ ! -f /usr/local/bin/picom ]; then
        VERSION=12.4
        wget -O picom.tar.gz https://github.com/yshui/picom/archive/v$VERSION.tar.gz
        tar xzf picom.tar.gz
        rm -rf picom.tar.gz
        pushd picom-$VERSION
        sudo apt install --yes \
            libconfig-dev \
            libdbus-1-dev \
            libepoxy-dev \
            libev-dev \
            libevdev-dev \
            libgl1-mesa-dev \
            libpcre3-dev \
            libpixman-1-dev \
            libx11-xcb-dev \
            libxcb-composite0-dev \
            libxcb-damage0-dev \
            libxcb-glx0-dev \
            libxcb-image0-dev \
            libxcb-present-dev \
            libxcb-randr0-dev \
            libxcb-render-util0-dev \
            libxcb-render0-dev \
            libxcb-shape0-dev \
            libxcb-util-dev \
            libxcb-xfixes0-dev \
            libxcb-xinerama0-dev \
            libxcb1-dev \
            libxext-dev \
            meson \
            uthash-dev
        meson --buildtype=release . build
        ninja -C build
        sudo ninja -C build install
        popd
        rm -rf picom-$VERSION
    fi

    stow i3
fi
