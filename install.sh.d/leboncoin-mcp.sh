#!/bin/bash -e
# DEPENDS: claude-code git uv

# leboncoin MCP server: search and read Leboncoin classifieds from Claude Code.
# https://github.com/wydii/leboncoin-mcp
#
# It wraps lbc, an unofficial client for the Leboncoin API, and is not published
# on PyPI, so it has to run from a checkout. uv builds the dependency env from
# requirements.txt on each launch (~250ms once cached), which avoids keeping a
# venv in sync here.

REPO_URL="https://github.com/wydii/leboncoin-mcp.git"
SRC_DIR="$HOME/local/src/leboncoin-mcp"

if [ -d "$SRC_DIR/.git" ]; then
    git -C "$SRC_DIR" pull --ff-only
else
    mkdir -p "$(dirname "$SRC_DIR")"
    git clone "$REPO_URL" "$SRC_DIR"
fi

# --no-project matters: Claude Code starts the server with the cwd of whatever
# project it runs in, and without it uv would try to sync that project's
# pyproject.toml instead of our requirements. --python pins an interpreter uv
# manages itself, so the pyenv shims stay out of the way (lbc needs 3.10+).
uv_run=(uv run --no-project --python 3.12 --with-requirements "$SRC_DIR/requirements.txt")

# Warm the uv cache and fail here if the dependencies stop resolving, rather
# than silently at the next Claude Code launch.
"${uv_run[@]}" python -c "import lbc, fastmcp"

# claude mcp add refuses to overwrite an existing entry, so drop it first: that
# makes re-runs idempotent and picks up any change to the command below.
claude mcp remove leboncoin -s user >/dev/null 2>&1 || true
claude mcp add leboncoin -s user -- "${uv_run[@]}" python "$SRC_DIR/server.py"

# The ChatGPT desktop app, the Codex CLI and the Codex IDE extension share one
# MCP config in ~/.codex/config.toml, so registering once covers all three.
# Optional: codex has no install script here, so only wire it up if present.
# Unlike claude, codex mcp add overwrites an existing entry, so no remove first.
# It does rewrite the whole config file (keys get reordered, empty arrays
# dropped), which is harmless but noticeable if you diff it.
if command -v codex >/dev/null; then
    codex mcp add leboncoin -- "${uv_run[@]}" python "$SRC_DIR/server.py"
fi

echo "leboncoin MCP registered (user scope). Tools: search_ads, get_ad,"
echo "get_user, list_categories, list_regions, list_departments."
echo "A 403 from Leboncoin means Datadome blocked the request: slow down, or"
echo "set a French residential proxy in $SRC_DIR/server.py."
