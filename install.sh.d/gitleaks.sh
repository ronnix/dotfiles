#!/bin/bash -e
# DEPENDS: brew curl

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions gitleaks >/dev/null; then
        brew install gitleaks
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # Gitleaks has no apt repository, so install the tarball from GitHub releases
    if ! command -v gitleaks >/dev/null; then
        case "$(dpkg --print-architecture)" in
            amd64) ARCH="x64" ;;
            arm64) ARCH="arm64" ;;
            armhf) ARCH="armv7" ;;
            *)
                echo "gitleaks: unsupported architecture $(dpkg --print-architecture)" >&2
                exit 1
                ;;
        esac
        VERSION="$(curl -fsSL https://api.github.com/repos/gitleaks/gitleaks/releases/latest |
            grep -oP '"tag_name":\s*"v\K[^"]+')"
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
