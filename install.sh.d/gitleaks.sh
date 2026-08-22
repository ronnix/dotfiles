#!/bin/bash -e
# DEPENDS: brew curl git stow

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions gitleaks >/dev/null; then
        brew install gitleaks
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # Gitleaks has no apt repository, so install the tarball from GitHub releases
    if needs_install command -v gitleaks; then
        case "$(dpkg --print-architecture)" in
            amd64) ARCH="x64" ;;
            arm64) ARCH="arm64" ;;
            armhf) ARCH="armv7" ;;
            *)
                echo "gitleaks: unsupported architecture $(dpkg --print-architecture)" >&2
                exit 1
                ;;
        esac
        TAG="$(github_latest_tag gitleaks/gitleaks)"
        VERSION="${TAG#v}"
        TARBALL="gitleaks_${VERSION}_linux_${ARCH}.tar.gz"
        URL="https://github.com/gitleaks/gitleaks/releases/download/v${VERSION}/${TARBALL}"
        TMP="$(mktemp -d)"
        curl -fsSL "${URL}" -o "${TMP}/${TARBALL}"
        tar xzf "${TMP}/${TARBALL}" -C "${TMP}" gitleaks
        mkdir -p ~/.local/bin
        install -m 755 "${TMP}/gitleaks" ~/.local/bin/gitleaks
        rm -rf "${TMP}"
    fi
fi

# Deploys ~/.git-template/hooks/pre-commit, which git copies into every
# repository created from now on (init.templateDir is set by the git module).
stow gitleaks
