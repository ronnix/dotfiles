# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a dotfiles management system for macOS and Linux using GNU Stow for symlink management. Each tool/application has its own module directory that mirrors the home directory structure.

## Key Commands

```bash
# Install specific modules (resolves dependencies automatically)
./install.sh python git zsh

# List available modules with their dependencies
./install.sh --list

# Run dependency resolution tests
./test_dependencies.sh
```

## Architecture

### Module Structure

Each module directory (e.g., `git/`, `python/`, `zsh/`) mirrors `$HOME`:
```
module_name/
├── .config/app/          → ~/.config/app/
├── .zshrc.d/module.zsh   → ~/.zshrc.d/module.zsh
├── .bashrc.d/module.sh   → ~/.bashrc.d/module.sh
└── .local/bin/script     → ~/.local/bin/script
```

Running `stow module_name` creates these symlinks.

### Install System

`install.sh` orchestrates installation by:
1. Reading `# DEPENDS: dep1 dep2` comments from scripts in `install.sh.d/`
2. Resolving the full dependency graph (transitive dependencies included)
3. Executing scripts in dependency order, skipping already-executed scripts

Platform detection uses `uname -s` to distinguish Darwin (macOS) vs Linux.

### Installation Script Pattern

Scripts in `install.sh.d/` follow this convention:
```bash
#!/bin/bash -e
# DEPENDS: stow brew  # declares dependencies

if [ "$(uname -s)" == "Darwin" ]; then
    brew install package
elif [ "$(uname -s)" == "Linux" ]; then
    sudo apt-get install package
fi

stow module_name  # symlink config files
```

### Install or update

A module that is already installed is left alone: guard every install step.
`./install.sh --update` overrides that, but only where it can do something no
package manager can. Pick the guard accordingly:

- **brew or apt owns the tool** — guard with `brew ls --versions`, `brew list
  --cask --versions` or `dpkg -s`, and leave it at that. Updating is
  `brew upgrade` / `apt upgrade`, not this script's job.
- **the script owns the install** (binary fetched from upstream, source build,
  `cargo install`, a wheel, a font, a vendor `curl | sh`) — source
  `lib/common.sh` and guard with `needs_install`, which also fires under
  `--update`:

```bash
# shellcheck source=lib/common.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

if needs_install command -v tool; then    # or: needs_install test -f /path
    ...
fi
```

`lib/common.sh` also provides `github_latest_tag <owner>/<repo>`, which returns
the raw tag of the latest release. Prefer it to a hardcoded version, and to
querying api.github.com, which rate-limits unauthenticated calls.

### Shell Configuration

Shell RC files (`~/.bashrc`, `~/.zshrc`) source all files in their `.d` subdirectories, allowing modular shell configuration per tool.

## Platform Differences

- **macOS**: Uses Homebrew (`brew install`), `gmv` for GNU move
- **Linux**: Uses apt-get, may compile from source (e.g., picom)
