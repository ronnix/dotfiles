#!/bin/bash -e
# DEPENDS: stow

curl -fsSL https://claude.ai/install.sh | bash

stow claude-code

# Inject statusline config into settings.json (preserving existing settings)
settings="$HOME/.claude/settings.json"
statusline_json='{"type":"command","command":"bash ~/.claude/statusline-command.sh"}'

if [ -f "$settings" ]; then
    cp "$settings" "$settings.bak"
    if jq --argjson sl "$statusline_json" '.statusLine = $sl' "$settings" > "$settings.tmp"; then
        mv "$settings.tmp" "$settings"
    else
        echo "jq failed, restoring backup" >&2
        mv "$settings.bak" "$settings"
        exit 1
    fi
else
    mkdir -p "$HOME/.claude"
    echo "{}" | jq --argjson sl "$statusline_json" '.statusLine = $sl' > "$settings"
fi
