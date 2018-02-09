source ~/.bash_functions

for script in ~/.bash_profile.d/*.sh; do
    if [ -x "${script}" ]; then
        source ${script}
    fi
done

source ~/.bashrc
