set -o errexit

if [ "$(uname -s)" == "Linux" ]; then
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
    wget https://github.com/fdw/rofimoji/releases/download/4.3.0/rofimoji-4.3.0-py3-none-any.whl
    pipx install rofimoji-4.3.0-py3-none-any.whl
    rm -f ./rofimoji-4.3.0-py3-none-any.whl

    # Install picom compositing manager
    if [ ! -f /usr/local/bin/picom ]; then
        VERSION=8.2
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
