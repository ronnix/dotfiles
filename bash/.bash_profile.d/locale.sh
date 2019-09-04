if [ "$(uname -s)" == "Darwin" ]; then
    export LANG=en_us.UTF-8
    export LC_ALL=en_us.UTF-8
elif [ "$(uname -s)" == "Linux" ]; then
    export LANG=en_US.utf8
    export LC_ALL=en_US.utf8
fi
