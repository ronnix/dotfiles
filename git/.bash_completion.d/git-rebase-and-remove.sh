_git_rebase_and_remove() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local branches=$(git branch --format='%(refname:short)' | grep -v '^main$')
    COMPREPLY=($(compgen -W "$branches" -- "$cur"))
}