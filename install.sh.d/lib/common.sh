# shellcheck shell=bash
#
# Helpers shared by the install scripts. Source it with:
#
#     source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

# Answer whether an install step should run.
#
# Takes the check the script would otherwise have run on its own, e.g.
# `needs_install command -v hunk`, `needs_install test -f /usr/local/bin/picom`.
# The step runs when that check fails, i.e. when the tool is missing — and
# always when install.sh was called with --update, so that installs no package
# manager owns can be refreshed on demand.
needs_install() {
    if [ -n "${DOTFILES_UPDATE:-}" ]; then
        return 0
    fi
    ! "$@" >/dev/null 2>&1
}

# Print the tag of a repository's latest release, e.g. `v1.2.3`.
#
# Resolved through the /releases/latest redirect rather than the GitHub API:
# the API rate-limits unauthenticated calls to 60 requests per hour and per IP,
# and its JSON cannot be parsed with `grep -oP` on macOS (BSD grep has no -P).
#
# A repository without a published release redirects to /releases and still
# answers 200, so check that we landed on a tag instead of trusting the last
# path component.
# Print the name of a release asset, matched on the tail of its name, e.g.
# `github_release_asset unslothai/unsloth v0.1.804-beta -Ubuntu.deb`.
#
# Upstreams do rename their assets — Unsloth dropped the version from theirs
# between two consecutive releases — so match the stable part of the name
# instead of rebuilding it. The expanded_assets page lists the names without
# going through the rate-limited API.
github_release_asset() {
    local repo="$1" tag="$2" suffix="$3" name
    name="$(curl -fsSL "https://github.com/${repo}/releases/expanded_assets/${tag}" |
        grep -oE "[A-Za-z0-9._-]+${suffix}" | head -1)"
    if [ -z "${name}" ]; then
        echo "${repo}: no ${tag} asset whose name ends in ${suffix}" >&2
        return 1
    fi
    echo "${name}"
}

github_latest_tag() {
    local repo="$1" url
    url="$(curl -fsSLI -o /dev/null -w '%{url_effective}' "https://github.com/${repo}/releases/latest")"
    case "${url}" in
        */releases/tag/*) echo "${url#*/releases/tag/}" ;;
        *)
            echo "${repo}: no published release" >&2
            return 1
            ;;
    esac
}
