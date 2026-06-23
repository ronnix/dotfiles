#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract data
user=$(whoami)
dir=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')
model="${model/ context)/)}"   # "Opus 4.8 (1M context)" -> "Opus 4.8 (1M)"
ctx_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
ctx_used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
git_branch=$(cd "$dir" 2>/dev/null && git --no-optional-locks -c core.useBuiltinFSMonitor=false -c core.fsmonitor=false branch --show-current 2>/dev/null)
git_dirty=$(cd "$dir" 2>/dev/null && [ -n "$(git --no-optional-locks -c core.useBuiltinFSMonitor=false -c core.fsmonitor=false status --porcelain 2>/dev/null)" ] && echo '*' || echo '')
time=$(date '+%H:%M')

# Abrege un chemin facon fish : chaque dossier reduit a ses points de tete +
# sa 1re lettre (.worktrees -> .w). Restent entiers le dernier composant et,
# si fourni, le composant a l'index $2 (le nom du projet, cf. plus bas).
abbrege_chemin() {
    local chemin="$1" garder_idx="${2:--1}"
    local -a parties
    IFS='/' read -ra parties <<< "$chemin"
    local n=${#parties[@]}
    local sortie="" i p dots reste
    for ((i=0; i<n; i++)); do
        p="${parties[i]}"
        if [ $i -eq $((n-1)) ] || [ $i -eq "$garder_idx" ]; then
            sortie+="$p"                       # composant garde entier
        elif [ -z "$p" ]; then
            :                                  # composant vide (racine /)
        else
            dots="${p%%[!.]*}"                 # points de tete
            reste="${p#"$dots"}"
            sortie+="${dots}${reste:0:1}"      # points + 1er caractere
        fi
        [ $i -lt $((n-1)) ] && sortie+="/"
    done
    printf '%s' "${sortie:-/}"                  # garde la racine "/"
}

# Racine du depot principal pour garder son nom lisible. En worktree,
# --git-common-dir pointe vers le .git du repo principal (pas du worktree),
# donc son parent est bien .../mon-assistant-civil.
racine_projet=$(cd "$dir" 2>/dev/null && git --no-optional-locks -c core.useBuiltinFSMonitor=false -c core.fsmonitor=false rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
racine_projet="${racine_projet%/*}"

# Raccourcit le chemin : $HOME -> ~ puis abreviation des dossiers.
# NB: passer le ~ par une variable, sinon bash 5.x le tilde-expanse dans la
# chaine de remplacement (~ redevient $HOME -> aucun changement visible).
tilde='~'
chemin_affiche="${dir/#$HOME/$tilde}"
projet_idx=-1
if [ -n "$racine_projet" ]; then
    racine_affiche="${racine_projet/#$HOME/$tilde}"
    # Ne garder l'index que si la racine est bien un prefixe du chemin courant.
    if [ "$chemin_affiche" = "$racine_affiche" ] || [ "${chemin_affiche#"$racine_affiche"/}" != "$chemin_affiche" ]; then
        IFS='/' read -ra _rp <<< "$racine_affiche"
        projet_idx=$(( ${#_rp[@]} - 1 ))
    fi
fi
dir_court=$(abbrege_chemin "$chemin_affiche" "$projet_idx")

# Format context window: k-tokens remplis + pourcentage d'utilisation entre parenthèses
if [ -n "$ctx_tokens" ]; then
    ctx_k=$(( (ctx_tokens + 500) / 1000 ))  # arrondi au millier le plus proche
    if [ -n "$ctx_used_pct" ]; then
        ctx="${ctx_k}k (${ctx_used_pct}%)"
    else
        ctx="${ctx_k}k"
    fi
else
    ctx="--"
fi

# Powerline separators
sep=$'\xee\x82\xb0'        # U+E0B0  (sharp, between segments)
sep_right=$'\xee\x82\xb4'  # U+E0B4  (rounded right, trailing edge)
sep_left=$'\xee\x82\xb6'   # U+E0B6  (rounded left, leading edge)

# Catppuccin Mocha colors
pink="243;139;168"
peach="250;179;135"
yellow="249;226;175"
green="166;227;161"
mauve="203;166;247"
lavender="180;190;254"
dark="17;17;27"

# Leading separator
printf "\033[38;2;${pink}m${sep_left}\033[0m"
# User (pink)
printf "\033[48;2;${pink};38;2;${dark}m 󰀵 %s \033[0m" "$user"
# Pink -> Peach transition
printf "\033[48;2;${peach};38;2;${pink}m${sep}\033[0m"
# Directory (peach)
printf "\033[48;2;${peach};38;2;${dark}m %s \033[0m" "$dir_court"
# Peach -> Yellow transition
printf "\033[48;2;${yellow};38;2;${peach}m${sep}\033[0m"
# Git branch (yellow)
printf "\033[48;2;${yellow};38;2;${dark}m %s%s \033[0m" "${git_branch}" "${git_dirty}"
# Yellow -> Green transition
printf "\033[48;2;${green};38;2;${yellow}m${sep}\033[0m"
# Model (green)
printf "\033[48;2;${green};38;2;${dark}m 󰧑 %s \033[0m" "$model"
# Green -> Mauve transition
printf "\033[48;2;${mauve};38;2;${green}m${sep}\033[0m"
# Context window (mauve)
printf "\033[48;2;${mauve};38;2;${dark}m 󱤓 %s \033[0m" "$ctx"
# Mauve -> Lavender transition
printf "\033[48;2;${lavender};38;2;${mauve}m${sep}\033[0m"
# Time (lavender)
printf "\033[48;2;${lavender};38;2;${dark}m  %s \033[0m" "$time"
# Trailing separator
printf "\033[38;2;${lavender}m${sep_right}\033[0m"
