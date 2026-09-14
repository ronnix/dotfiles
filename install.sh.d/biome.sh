#!/bin/bash -e
# DEPENDS: brew curl

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions biome >/dev/null; then
        brew install biome
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # https://biomejs.dev/install.sh is gone (404) and the `curl | bash` that
    # called it swallowed the failure, since a pipeline reports the exit status
    # of bash, which happily reads an empty script. Install the standalone
    # binary from GitHub releases instead.
    if needs_install command -v biome; then
        case "$(uname -m)" in
            x86_64) ARCH="x64" ;;
            aarch64 | arm64) ARCH="arm64" ;;
            *)
                echo "biome: unsupported architecture $(uname -m), skipping" >&2
                exit 0
                ;;
        esac
        # Tags look like @biomejs/biome@2.5.13, slashes and all
        TAG="$(github_latest_tag biomejs/biome)"
        mkdir -p "$HOME/.local/bin"
        curl -fsSL "https://github.com/biomejs/biome/releases/download/${TAG}/biome-linux-${ARCH}" \
            -o "$HOME/.local/bin/biome"
        chmod +x "$HOME/.local/bin/biome"
    fi
fi
