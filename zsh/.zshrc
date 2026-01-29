# Homebrew completions
if [[ -d /opt/homebrew/share/zsh/site-functions ]]; then
    fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fi

# Init completion
autoload -Uz compinit && compinit

# Recherche dans l'historique avec les flèches haut et bas
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Charger tous les fichiers .zsh du répertoire ~/.zshrc.d/
if [[ -d ~/.zshrc.d ]]; then
    for file in ~/.zshrc.d/*.zsh; do
        [[ -r "$file" ]] && source "$file"
    done
fi

# Prompt personnalisé
eval "$(starship init zsh)"

. "$HOME/.local/bin/env"
