# Initialize Homebrew on Apple Silicon or Intel, including non-login shells.
for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew
    if test -x "$brew_bin"
        eval ($brew_bin shellenv fish)
        break
    end
end

set -gx GOPATH "$HOME/go"
set -gx PYTHONDONTWRITEBYTECODE 1
set -gx EDITOR 'zed --wait'
set -gx VISUAL "$EDITOR"

set -gx BUN_INSTALL "$HOME/.bun"
set -gx PNPM_HOME "$HOME/Library/pnpm"

# Preserve the existing Claude Code backend. Local config can override it.
set -gx CLAUDE_CODE_USE_VERTEX 1
set -gx ANTHROPIC_VERTEX_PROJECT_ID vivaa-dev-backend

# Load local overrides before the integrations that use them.
if test -f "$__fish_config_dir/config.local.fish"
    source "$__fish_config_dir/config.local.fish"
end
fish_add_path --path "$HOME/.local/bin" "$GOPATH/bin" "$BUN_INSTALL/bin" "$PNPM_HOME"

# Modern asdf uses shims. Keep the old checkout usable until it is migrated.
if not type -q asdf; and test -f "$HOME/.asdf/asdf.fish"
    source "$HOME/.asdf/asdf.fish"
end
set -l asdf_data_dir "$HOME/.asdf"
if set -q ASDF_DATA_DIR
    set asdf_data_dir "$ASDF_DATA_DIR"
end
fish_add_path --path --move "$asdf_data_dir/shims"

if test -f "$HOME/google-cloud-sdk/path.fish.inc"
    source "$HOME/google-cloud-sdk/path.fish.inc"
end

if status is-interactive
    source "$__fish_config_dir/aliases.fish"
    set -g fish_greeting
    set -gx FZF_DEFAULT_COMMAND 'rg --files'

    if set -q HOMEBREW_PREFIX; and test -f "$HOMEBREW_PREFIX/share/autojump/autojump.fish"
        source "$HOMEBREW_PREFIX/share/autojump/autojump.fish"
    end
    if type -q direnv
        direnv hook fish | source
    end
    if isatty stdin
        set -gx GPG_TTY (tty)
    end
end
