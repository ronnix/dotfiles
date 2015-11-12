# Prompt
export PS1='\
\[\e]2;\]\u@\h:\w\[\a\]\
\[\e]1;\]\W\[\a\]\
\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]'
if [ -f /usr/local/bin/git-prompt.sh ]; then
  . /usr/local/bin/git-prompt.sh
  PS1=$PS1$(__git_ps1 " (%s)")
fi
PS1=$PS1'\n\$ '

# \u: current user
# \h: current host
# \w: current directory
# \$: either $ or #
# \[\]: do not count characters in between

# => Put the string "user@hostname:~/directory/path" in the iTerm2 title bar
# \[\e]2;\]\u@\h:\w\[\a\]

# => Put the current directory in the iTerm2 tab
# \[\e]1;\]\W\[\a\]

# => Put the string "user@hostname:~/directory/path" in the prompt (with nice colors)
#\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]

# History
export HISTCONTROL=ignoredups:erasedups     # no duplicate entries
export HISTSIZE=100000                      # big big history
export HISTFILESIZE=100000                  # big big history

# Append history to ~/.bash_history instead of overwriting it
shopt -s histappend

# Save history after each command
export PROMPT_COMMAND='history -a'
