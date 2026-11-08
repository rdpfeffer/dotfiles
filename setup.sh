#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Stow refuses to overwrite existing files. Preview all packages before linking.
# --no-folding keeps generated Fish files out of this repository.
stow --dir="$repo_dir" --target="$HOME" --no-folding --simulate git fish postgres python ghostty zed
stow --dir="$repo_dir" --target="$HOME" --no-folding git fish postgres python ghostty zed

echo "Dotfiles linked. Existing files were not replaced."
echo "See README.md for optional shell, Git signing, and macOS setup."
