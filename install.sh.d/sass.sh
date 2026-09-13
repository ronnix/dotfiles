#!/bin/bash -e
# DEPENDS: brew curl dart

# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

if [ "$(uname -s)" == "Darwin" ]; then
    # Built from source with the Dart SDK, hence the dependency on dart
    brew trust --formula sass/sass/sass
    if ! brew ls --versions sass >/dev/null; then
        brew install sass/sass/sass
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # No apt repository: install the standalone release under ~/.local
    if needs_install command -v sass; then
        case "$(uname -m)" in
            x86_64) ARCH=x64 ;;
            aarch64) ARCH=arm64 ;;
            *) echo "sass: unsupported architecture $(uname -m)" >&2; exit 1 ;;
        esac
        VERSION="$(github_latest_tag sass/dart-sass)"
        URL="https://github.com/sass/dart-sass/releases/download/${VERSION}/dart-sass-${VERSION}-linux-${ARCH}.tar.gz"
        mkdir -p "${HOME}/.local/lib" "${HOME}/.local/bin"
        rm -rf "${HOME}/.local/lib/dart-sass"
        curl -fsSL "${URL}" | tar -xz -C "${HOME}/.local/lib"
        ln -sf "${HOME}/.local/lib/dart-sass/sass" "${HOME}/.local/bin/sass"
    fi
fi
