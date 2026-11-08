#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Remove only links managed by this repository. Leave packages and user data alone.
stow --dir="$repo_dir" --target="$HOME" --no-folding --delete git fish postgres python ghostty zed
echo "Dotfile links removed. Software, shell selection, and other files are unchanged."
