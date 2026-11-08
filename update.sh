#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Update only packages declared by this repository. Do not uninstall other tools.
brew update
brew bundle install --file="$repo_dir/Brewfile"
