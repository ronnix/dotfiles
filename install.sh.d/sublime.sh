stow sublime

# Add symbolic link on macOS
if [[ $(uname -s) == 'Darwin' ]]; then
    if [ ! -L /usr/local/bin/subl ]; then
        ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
    fi
fi
