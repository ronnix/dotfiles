#!/bin/bash -e
# DEPENDS: brew curl stow

# Expose the bundled hunk-review skill through skillshare so it reaches every
# configured agent. skillshare only discovers real directories, so we create one
# holding a symlink to the bundled SKILL.md — the file stays in sync across hunk
# upgrades while the directory remains discoverable.
expose_hunk_skill() {
    command -v skillshare >/dev/null || return 0
    local skill_md="$1"
    [ -f "${skill_md}" ] || return 0
    local ss_source="$HOME/.config/skillshare/skills"
    [ -d "${ss_source}" ] || return 0
    local dest="${ss_source}/hunk-review"
    [ -L "${dest}" ] && rm -f "${dest}" # drop a legacy directory symlink if present
    mkdir -p "${dest}"
    ln -sfn "${skill_md}" "${dest}/SKILL.md"
    skillshare sync >/dev/null
}

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions hunk >/dev/null; then
        brew install hunk
    fi
    expose_hunk_skill "$(brew --prefix hunk)/libexec/skills/hunk-review/SKILL.md"
elif [ "$(uname -s)" == "Linux" ]; then
    # Hunk has no apt repository, so install the standalone binary from GitHub releases
    if ! command -v hunk >/dev/null; then
        case "$(uname -m)" in
            x86_64) ARCH="x64" ;;
            aarch64 | arm64) ARCH="arm64" ;;
            *)
                echo "Unsupported architecture: $(uname -m)" >&2
                exit 1
                ;;
        esac
        VERSION="$(curl -fsSL https://api.github.com/repos/modem-dev/hunk/releases/latest |
            grep -oP '"tag_name":\s*"v\K[^"]+')"
        TARBALL="hunkdiff-linux-${ARCH}.tar.gz"
        URL="https://github.com/modem-dev/hunk/releases/download/v${VERSION}/${TARBALL}"
        TMP="$(mktemp -d)"
        curl -fsSL "${URL}" | tar xz -C "${TMP}"
        mkdir -p "$HOME/.local/bin"
        install -m 755 "${TMP}/hunkdiff-linux-${ARCH}/hunk" "$HOME/.local/bin/hunk"
        # Keep the bundled review skill so skillshare can expose it
        mkdir -p "$HOME/.local/share/hunk/skills"
        cp -R "${TMP}/hunkdiff-linux-${ARCH}/skills/hunk-review" "$HOME/.local/share/hunk/skills/"
        rm -rf "${TMP}"
    fi
    expose_hunk_skill "$HOME/.local/share/hunk/skills/hunk-review/SKILL.md"
fi

# Install config files
stow hunk
