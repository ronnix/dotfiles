#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract data
user=$(whoami)
dir=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')
context_pct=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
git_branch=$(cd "$dir" 2>/dev/null && git -c core.useBuiltinFSMonitor=false -c core.fsmonitor=false branch --show-current 2>/dev/null)
git_dirty=$(cd "$dir" 2>/dev/null && [ -n "$(git -c core.useBuiltinFSMonitor=false -c core.fsmonitor=false status --porcelain 2>/dev/null)" ] && echo '*' || echo '')
time=$(date '+%H:%M')

# Format context percentage
if [ -n "$context_pct" ]; then
    ctx="${context_pct}%"
else
    ctx="--%"
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
printf "\033[48;2;${peach};38;2;${dark}m %s \033[0m" "${dir/#$HOME/~}"
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
