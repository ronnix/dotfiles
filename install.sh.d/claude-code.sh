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

# Custom spinner verbs. Claude Code appends the ellipsis itself, so the strings
# must not contain one. English uses present participles ("Pondering"), which
# have no idiomatic French equivalent: a bare "-ant" participle reads as an
# adjective, not an action in progress. These use nominalization instead, the
# standard French UI form ("Chargement", "Connexion"), with "En train de +
# infinitif" as a fallback where no natural noun exists.
spinner_verbs_json='{"mode":"replace","verbs":[
    "Caféinage","Cogitation","Percolation","Gribouillage","Pianotage",
    "Tergiversation","Ratiocination","Bidouillage","Tripatouillage",
    "Marmonnement","Grommellement","Vrombissement","Rumination",
    "Élucubration","Circonvolution","Tournicotage","Fignolage",
    "Ronronnement","Phosphorage","Alambiquage","Pinaillage","Vaticination",
    "Lévitation","Reptation","Macération","Procrastination","Bourdonnement",
    "Chuchotement","Bûcheronnage","En train de zoner","En train de tiquer",
    "Creepage","Redstonage","Minage","Enchantement","Endermanage",
    "Néthérisation","Piglinage","Piochage","Réapparition","Amorçage de TNT",
    "Empilage de blocs"
]}'

# shellcheck disable=SC2016  # $sl/$cleanup/$coauthored/$verbs are jq vars, not shell vars
jq_filter='.statusLine = $sl
    | .cleanupPeriodDays = $cleanup
    | .includeCoAuthoredBy = $coauthored
    | .spinnerVerbs = $verbs'

if [ -f "$settings" ]; then
    cp "$settings" "$settings.bak"
    if jq --argjson sl "$statusline_json" \
        --argjson cleanup "$cleanup_period_days" \
        --argjson coauthored "$include_co_authored_by" \
        --argjson verbs "$spinner_verbs_json" \
        "$jq_filter" "$settings" >"$settings.tmp"; then
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
        --argjson verbs "$spinner_verbs_json" \
        "$jq_filter" >"$settings"
fi
