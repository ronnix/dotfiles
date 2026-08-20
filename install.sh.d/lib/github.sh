# shellcheck shell=bash
#
# Helpers shared by the install scripts that fetch artifacts from GitHub
# releases. Source it with:
#
#     source "$(dirname "${BASH_SOURCE[0]}")/lib/github.sh"

# Print the tag of a repository's latest release, e.g. `v1.2.3`.
#
# Resolved through the /releases/latest redirect rather than the GitHub API:
# the API rate-limits unauthenticated calls to 60 requests per hour and per IP,
# and its JSON cannot be parsed with `grep -oP` on macOS (BSD grep has no -P).
#
# A repository without a published release redirects to /releases and still
# answers 200, so check that we landed on a tag instead of trusting the last
# path component.
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
