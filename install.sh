#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SECONDS=0

if [[ "$(uname -s)" != Darwin ]]; then
    echo "This installer requires macOS." >&2
    exit 1
fi

echo "==> Checking for Homebrew..."

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
echo "==> Installing missing packages from $repo_dir/Brewfile"
echo "Homebrew may refresh package metadata before showing package progress."
echo "First-time installs can take several minutes."

# Verbose mode streams subprocess output that Bundle otherwise captures.
if brew bundle install --verbose --file="$repo_dir/Brewfile"; then
    echo "Packages installed in ${SECONDS}s. Run ./setup.sh to link the configuration."
else
    status=$?
    echo "Installation failed after ${SECONDS}s (exit $status). See the Homebrew output above." >&2
    echo "You can rerun this script after fixing the error." >&2
    exit "$status"
fi
