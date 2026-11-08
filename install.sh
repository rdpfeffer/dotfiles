#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$(uname -s)" != Darwin ]]; then
    echo "This installer requires macOS." >&2
    exit 1
fi

# Homebrew supports Apple Silicon and Intel Macs.
if ! command -v brew >/dev/null 2>&1; then
    for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
        if [[ -x "$brew_bin" ]]; then
            eval "$("$brew_bin" shellenv)"
            break
        fi
    done
fi

if ! command -v brew >/dev/null 2>&1; then
    echo "Install Homebrew from https://brew.sh, then run this script again." >&2
    exit 1
fi

# Do not upgrade existing packages during initial installation.
export HOMEBREW_BUNDLE_NO_UPGRADE=1
brew bundle install --file="$repo_dir/Brewfile"
echo "Packages installed. Run ./setup.sh to link the configuration."
