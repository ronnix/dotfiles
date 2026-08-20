#!/bin/bash -e
# DEPENDS: brew curl

# shellcheck source=lib/github.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/github.sh"

if [ "$(uname -s)" == "Darwin" ]; then
    if ! brew ls --versions supabase >/dev/null; then
        brew install supabase/tap/supabase
    fi
elif [ "$(uname -s)" == "Linux" ]; then
    # Supabase has no apt repository, so install the .deb from GitHub releases
    if ! command -v supabase >/dev/null; then
        ARCH="$(dpkg --print-architecture)"
        TAG="$(github_latest_tag supabase/cli)"
        VERSION="${TAG#v}"
        DEB="supabase_${VERSION}_linux_${ARCH}.deb"
        URL="https://github.com/supabase/cli/releases/download/v${VERSION}/${DEB}"
        TMP="$(mktemp -d)"
        curl -fsSL "${URL}" -o "${TMP}/${DEB}"
        sudo dpkg -i "${TMP}/${DEB}"
        rm -rf "${TMP}"
    fi
fi
