# Bash completions
export USER_BASH_COMPLETION_DIR=~/.bash_completion.d
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# Homebrew
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

for script in ~/.bash_profile.d/*.sh; do
    if [ -x "${script}" ]; then
        source ${script}
    fi
done

source ~/.bashrc
