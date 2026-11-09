#!/usr/bin/env bash
# Run without changing the real home directory or installing software.
# Fish expands the single-quoted scripts, not Bash.
# shellcheck disable=SC2016
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
for tool in stow fish shellcheck git python3; do
    command -v "$tool" >/dev/null || { echo "Missing test tool: $tool" >&2; exit 1; }
done
fish_bin="$(command -v fish)"
# Resolve the interpreter before HOME changes; asdf shims depend on HOME.
python_bin="$(python3 -c 'import sys; print(sys.executable)')"
original_path="$PATH"
test_dir="$(mktemp -d)"
trap 'rm -rf "$test_dir"' EXIT
export HOME="$test_dir/home with spaces"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
mkdir -p "$HOME" "$test_dir/bin"

passed=0
pass() {
    passed=$((passed + 1))
    echo "ok $passed - $1"
}

shellcheck "$repo_dir/"*.sh "$repo_dir/tests/run.sh"
for script in "$repo_dir/"*.sh; do /bin/bash -n "$script"; done
while IFS= read -r file; do
    "$fish_bin" --no-config --no-execute "$file"
done < <(find "$repo_dir/fish" -name '*.fish' -type f)
pass 'Bash and Fish syntax and ShellCheck'

# Any unexpected system-changing command makes the test fail.
for tool in sudo curl defaults chsh chpass killall brew; do
    printf '#!/bin/bash\necho "Unexpected command: %s" >&2\nexit 99\n' "$tool" > "$test_dir/bin/$tool"
    chmod +x "$test_dir/bin/$tool"
done
export PATH="$test_dir/bin:$original_path"
cd "$test_dir"
"$repo_dir/setup.sh"
[[ -L "$HOME/.gitconfig" && -L "$HOME/.config/fish/config.fish" ]]
[[ -L "$HOME/.psqlrc" && -L "$HOME/.isort.cfg" ]]
[[ ! -L "$HOME/.config/fish" ]]
[[ ! -e "$HOME/.vimrc" && ! -e "$HOME/.config/fish/fishfile" ]]
pass 'Setup links from another working directory without system changes'

"$repo_dir/setup.sh"
pass 'Setup can run twice'

ghostty_config="$HOME/Library/Application Support/com.mitchellh.ghostty/config"
zed_config="$HOME/.config/zed/settings.json"
[[ -L "$ghostty_config" && -L "$zed_config" ]]
[[ ! -L "$HOME/Library" && ! -L "$HOME/.config/zed" ]]
grep -Fxq 'font-family = Red Hat Mono' "$ghostty_config"
grep -Fxq 'theme = Desert' "$ghostty_config"
"$python_bin" - "$zed_config" <<'PY'
import json
import sys

with open(sys.argv[1]) as config_file:
    config = json.load(config_file)
assert config["buffer_font_family"] == "Red Hat Mono"
assert config["terminal"]["font_family"] == "Red Hat Mono"
assert config["terminal"]["shell"]["program"] == "fish"
assert config["vim_mode"] is True
PY
pass 'Ghostty and Zed preserve local preferences and use Red Hat Mono'

[[ "$(git config --file "$HOME/.gitconfig" core.editor)" == 'zed --wait' ]]
[[ "$(git config --file "$HOME/.gitconfig" alias.bh)" == *for-each-ref* ]]
pass 'Git uses Zed and preserves the branch-history alias'

# --no-config prevents host plugins from loading. Source only our test config.
env -i HOME="$HOME" PATH="$PATH" XDG_CONFIG_HOME="$XDG_CONFIG_HOME" \
    "$fish_bin" --no-config -c '
        source "$HOME/.config/fish/config.fish"
        test "$EDITOR" = "zed --wait"; or exit 1
        test "$VISUAL" = "$EDITOR"; or exit 1
        set -l original_path $PATH
        source "$HOME/.config/fish/config.fish"
        test (string join : $original_path) = (string join : $PATH); or exit 1
    '
pass 'Fish config works without optional tools and does not duplicate PATH'

printf 'set -gx DOTFILES_LOCAL_TEST loaded\n' > "$HOME/.config/fish/config.local.fish"
env -i HOME="$HOME" PATH="$PATH" XDG_CONFIG_HOME="$XDG_CONFIG_HOME" \
    "$fish_bin" --no-config -c '
        source "$HOME/.config/fish/config.fish"
        test "$DOTFILES_LOCAL_TEST" = loaded
    '
pass 'Fish loads private local configuration'

mkdir -p "$HOME/custom-asdf/shims"
printf 'set -gx ASDF_DATA_DIR "$HOME/custom-asdf"\n' >> "$HOME/.config/fish/config.local.fish"
env -i HOME="$HOME" PATH="$PATH:$HOME/custom-asdf/shims" XDG_CONFIG_HOME="$XDG_CONFIG_HOME" \
    "$fish_bin" --no-config -c '
        source "$HOME/.config/fish/config.fish"
        test "$PATH[1]" = "$HOME/custom-asdf/shims"; or exit 1
        set -l original_path $PATH
        source "$HOME/.config/fish/config.fish"
        test (string join : $original_path) = (string join : $PATH)
    '
pass 'Local asdf shims take priority and PATH remains repeatable'

env -i HOME="$HOME" PATH="$PATH" XDG_CONFIG_HOME="$XDG_CONFIG_HOME" TERM=xterm \
    "$fish_bin" --no-config --interactive -c '
        source "$HOME/.config/fish/config.fish"
        functions -q k; or exit 1
        test -z "$fish_greeting"
    '
pass 'Interactive Fish loads aliases without legacy plugins'

# Verify argument forwarding without running kubectl or changing Git history.
env -i HOME="$HOME" PATH="$PATH" \
    "$fish_bin" --no-config -c '
        source "$HOME/.config/fish/aliases.fish"
        functions k | string match -q "*kubectl \$argv*"; or exit 1
        functions dim | string match -q "*git diff \$argv*"; or exit 1
    '
pass 'Shell aliases forward arguments'

printf 'keep me\n' > "$HOME/.config/unrelated"
printf 'cache data\n' > "$HOME/.cache-data"
printf 'keep Zed data\n' > "$HOME/.config/zed/unrelated"
printf 'keep Ghostty data\n' > "$HOME/Library/Application Support/com.mitchellh.ghostty/unrelated"
"$repo_dir/uninstall.sh"
[[ ! -L "$HOME/.gitconfig" && ! -L "$HOME/.config/fish/config.fish" ]]
[[ ! -L "$ghostty_config" && ! -L "$zed_config" ]]
[[ -f "$HOME/.config/zed/unrelated" ]]
[[ -f "$HOME/Library/Application Support/com.mitchellh.ghostty/unrelated" ]]
[[ "$(< "$HOME/.config/unrelated")" == 'keep me' ]]
[[ -f "$HOME/.config/fish/config.local.fish" && -f "$HOME/.cache-data" ]]
pass 'Uninstall preserves private config and unrelated files'

printf 'existing git config\n' > "$HOME/.gitconfig"
if "$repo_dir/setup.sh" > "$test_dir/conflict.log" 2>&1; then
    echo 'Setup should refuse conflicting files' >&2
    exit 1
fi
[[ "$(< "$HOME/.gitconfig")" == 'existing git config' ]]
[[ ! -e "$HOME/.psqlrc" && ! -e "$HOME/.config/fish/config.fish" ]]
pass 'Setup refuses conflicts without partially linking packages'

rm "$HOME/.gitconfig"
for config in "$ghostty_config" "$zed_config"; do
    mkdir -p "$(dirname "$config")"
    printf 'existing app config\n' > "$config"
    if "$repo_dir/setup.sh" > "$test_dir/app-conflict.log" 2>&1; then
        echo 'Setup should refuse existing app configuration' >&2
        exit 1
    fi
    [[ "$(< "$config")" == 'existing app config' ]]
    [[ ! -e "$HOME/.gitconfig" && ! -e "$HOME/.psqlrc" ]]
    rm "$config"
done
pass 'Setup preserves existing Ghostty and Zed files without partial linking'

# Install/update tests use a fake brew. They never install packages.
export DOTFILES_BREW_LOG="$test_dir/brew.log"
cat > "$test_dir/bin/brew" <<'MOCK'
#!/bin/bash
printf '%s|%s\n' "$*" "${HOMEBREW_BUNDLE_NO_UPGRADE:-}" >> "$DOTFILES_BREW_LOG"
if [[ "$*" == *--verbose* ]]; then
    echo 'Mock Homebrew progress'
fi
MOCK
chmod +x "$test_dir/bin/brew"
"$repo_dir/install.sh" > "$test_dir/install.log" 2>&1
grep -Fq "bundle install --verbose --file=$repo_dir/Brewfile|1" "$DOTFILES_BREW_LOG"
pass 'Install uses the repo Brewfile without requesting upgrades'

"$python_bin" - "$test_dir/install.log" <<'PY'
import sys

with open(sys.argv[1]) as log_file:
    output = log_file.read()
assert output.index("Checking for Homebrew") < output.index("Installing missing packages")
assert output.index("Installing missing packages") < output.index("Mock Homebrew progress")
assert output.index("Mock Homebrew progress") < output.index("Packages installed in")
assert "metadata" in output
PY
pass 'Install announces work before Homebrew runs and shows progress and elapsed time'

: > "$DOTFILES_BREW_LOG"
"$repo_dir/update.sh"
grep -Fxq 'update|' "$DOTFILES_BREW_LOG"
grep -Fxq "bundle install --file=$repo_dir/Brewfile|" "$DOTFILES_BREW_LOG"
[[ "$(wc -l < "$DOTFILES_BREW_LOG" | tr -d ' ')" == 2 ]]
pass 'Update affects only declared dependencies, without cleanup or uninstalls'

printf '#!/bin/bash\necho "Mock package failure" >&2\nexit 42\n' > "$test_dir/bin/brew"
if "$repo_dir/install.sh" > "$test_dir/install-failure.log" 2>&1; then
    echo 'Install should propagate package failures' >&2
    exit 1
else
    [[ "$?" == 42 ]]
fi
grep -Fq 'Mock package failure' "$test_dir/install-failure.log"
grep -Fq 'Installation failed' "$test_dir/install-failure.log"
if grep -Fq 'Packages installed in' "$test_dir/install-failure.log"; then
    echo 'Install should not report success after failure' >&2
    exit 1
fi
if "$repo_dir/update.sh" > "$test_dir/update-failure.log" 2>&1; then
    echo 'Update should propagate package failures' >&2
    exit 1
fi
pass 'Install and update return failure when Homebrew fails'

echo "Passed $passed checks."
