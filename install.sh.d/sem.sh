#!/bin/bash -e
# DEPENDS: brew cargo curl

# cf. https://ataraxy-labs.github.io/sem/
# Semantic layer on top of Git: entity-level diff, blame, impact and log.
# Note: we deliberately do not run `sem setup`, which would hijack `git diff`.

# Expose sem's official agent skill through skillshare so it reaches every
# configured agent. The skill is not bundled in the brew formula, so download
# it from the release tag matching the installed version.
expose_sem_skill() {
    command -v skillshare >/dev/null || return 0
    local ss_source="$HOME/.config/skillshare/skills"
    [ -d "${ss_source}" ] || return 0
    local version
    version="$(sem --version | awk '{print $2}')" || return 0
    mkdir -p "${ss_source}/sem"
    curl -fsSL "https://raw.githubusercontent.com/Ataraxy-Labs/sem/v${version}/skills/sem/SKILL.md" \
        -o "${ss_source}/sem/SKILL.md"
    skillshare sync >/dev/null
}

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions sem-cli >/dev/null; then
        brew install sem-cli
    fi
    # GNU parallel also ships a `sem` binary (alias for `parallel --semaphore`)
    # which owns /opt/homebrew/bin/sem; link sem-cli's binary into ~/.local/bin,
    # which comes first in PATH.
    mkdir -p "$HOME/.local/bin"
    ln -sf /opt/homebrew/opt/sem-cli/bin/sem "$HOME/.local/bin/sem"
elif [ "$(uname -s)" == "Linux" ]; then
    if ! command -v sem >/dev/null; then
        cargo install --git https://github.com/Ataraxy-Labs/sem sem-cli
    fi
fi

PATH="$HOME/.local/bin:$PATH" expose_sem_skill
