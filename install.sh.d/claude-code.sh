#!/bin/bash -e
# DEPENDS: stow jq

curl -fsSL https://claude.ai/install.sh | bash

stow claude-code

# Merge managed settings into settings.json (preserving existing settings).
# Only stable, machine-independent keys are versioned here; Claude Code owns
# the rest (permissions, plugins, model, effortLevel, tui, ...).
settings="$HOME/.claude/settings.json"
statusline_json='{"type":"command","command":"bash ~/.claude/statusline-command.sh"}'
cleanup_period_days=365
include_co_authored_by=true

# shellcheck disable=SC2016  # $sl/$cleanup/$coauthored are jq vars, not shell vars
jq_filter='.statusLine = $sl
    | .cleanupPeriodDays = $cleanup
    | .includeCoAuthoredBy = $coauthored'

if [ -f "$settings" ]; then
    cp "$settings" "$settings.bak"
    if jq --argjson sl "$statusline_json" \
          --argjson cleanup "$cleanup_period_days" \
          --argjson coauthored "$include_co_authored_by" \
          "$jq_filter" "$settings" > "$settings.tmp"; then
        mv "$settings.tmp" "$settings"
    else
        echo "jq failed, restoring backup" >&2
        mv "$settings.bak" "$settings"
        exit 1
    fi
else
    mkdir -p "$HOME/.claude"
    echo "{}" | jq --argjson sl "$statusline_json" \
                   --argjson cleanup "$cleanup_period_days" \
                   --argjson coauthored "$include_co_authored_by" \
                   "$jq_filter" > "$settings"
fi
