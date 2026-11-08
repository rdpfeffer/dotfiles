# Ryan Pfeffer's Dotfiles

macOS configuration for [Zed](https://zed.dev), [Ghostty](https://ghostty.org),
[Fish](https://fishshell.com), Git, and PostgreSQL. Editors and terminals use
Red Hat Mono. [GNU Stow](https://www.gnu.org/software/stow/) manages
the configuration links. Fish uses its built-in prompt and features; no plugin
manager is required.

## Install

1. Install Apple's command-line tools: `xcode-select --install`.
2. Install Homebrew using the instructions at <https://brew.sh>.
3. Clone this repo and review `Brewfile`.

```bash
git clone git@github.com:rdpfeffer/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
./setup.sh
```

`install.sh` installs missing Brewfile packages. It does not upgrade existing
packages. It does not install Homebrew or run remote scripts.

`setup.sh` links the Git, Fish, PostgreSQL, Python, Ghostty, and Zed configuration
into `$HOME`. It works from any directory. It previews all links first and stops
on conflicts. It does not overwrite files, change the login shell, apply macOS
preferences, or install language runtimes through asdf.

Stow does not link whole directories. This keeps generated configuration files
out of the repo.

**Updating an existing installation?** Read [Migration](#migration) first.

## Optional setup

### Fish as the login shell

Find the Fish executable with `command -v fish`. Add that exact path to
`/etc/shells` if it is missing. Then run `chsh -s /path/to/fish` and open
a new terminal.

Autojump and direnv load only when they are installed. Configure direnv per
project and review each `.envrc` before you run `direnv allow`.

### Zed

The Brewfile installs the stable Zed app. If `zed` is not on PATH, use Zed's
command palette to run **cli: install**. Git and `EDITOR` use `zed --wait`,
so a commit waits until you close its message file.

The tracked Zed settings preserve the existing font sizes, themes, window
behavior, Fish shell, and Vim keybindings. Red Hat Mono is set for both the
editor buffer and the integrated terminal. Vim keybindings do not require Vim
to be installed. Install the Catppuccin theme extension in Zed if it is missing.

### Ghostty and fonts

The Brewfile installs Ghostty and Red Hat Mono. The old Hack and Meslo font
entries have been removed; existing fonts are not uninstalled.

The tracked Ghostty config preserves the local Desert theme and Red Hat Mono.
It uses the same macOS path as the existing installation:

- Ghostty: `~/Library/Application Support/com.mitchellh.ghostty/config`
- Zed: `~/.config/zed/settings.json`

Before running setup, back up and move any existing regular files at those
paths outside the managed locations. Keep the rest of each application's
configuration directory. Setup refuses to replace existing files, even if
their contents match.

To install only the new app and font, rather than the full Brewfile:

```bash
brew install --cask ghostty font-red-hat-mono
```

If Ghostty is already installed outside Homebrew, you can keep that app.
Do not use `--force` to replace it. Homebrew's `--adopt` option can register
an existing app when its contents match the cask.

After linking the configuration, restart Zed and reload Ghostty's configuration
with Command+Shift+comma. The font must be installed before the apps can use it.

### Git identity and signing

The tracked config preserves the existing public email and signing-key ID.
It enables commit signing. Import or create the matching private key before
you commit.

Put machine-specific overrides in `~/.gitconfig.local`. For example:

```gitconfig
[user]
    signingkey = YOUR_KEY_ID
```

Authenticate the GitHub CLI with `gh auth login`. The credential helper finds
`gh` on PATH instead of using an Apple Silicon-specific path.

### Private shell configuration

Put private values and machine-specific overrides in
`~/.config/fish/config.local.fish`. This file loads in interactive and
non-interactive shells. Keep it quiet and avoid commands that require input.

The existing Claude Code Vertex backend is preserved in the tracked config.
Override or erase those variables in the local file if you use another backend.

### Language runtimes and Docker

Homebrew provides default Python, Node, Go, and Ruby installations.
Use project configuration to select other versions. Modern asdf uses
`$ASDF_DATA_DIR/shims`, or `~/.asdf/shims` by default.

An old asdf checkout remains usable until you migrate it. Follow
[asdf's upgrade guide](https://asdf-vm.com/guide/upgrading-to-v0-16.html)
when moving from the old shell-based version to the current executable.
Review your `.tool-versions` files and regenerate shims as directed by the guide.
Setup no longer selects global Python versions.

The Brewfile installs the Docker CLI, not a container runtime. Keep or install
your preferred runtime separately.

### macOS preferences

Review `macos.sh`, then run it explicitly if you want those preferences.
It does not run during setup. It does not change security checks, power
management, backups, or system services. It does not restart applications.

The `lock` Fish function sends the macOS Lock Screen shortcut through
System Events. macOS may require Accessibility permission for your terminal.

## Update and uninstall

```bash
./update.sh
./uninstall.sh
```

Update installs or upgrades only Brewfile packages and their required
dependencies. It does not run global pip, npm, or gem updates. Homebrew resolves
the stable versions available when you run it; this is not a version lockfile.

Uninstall removes only this repo's managed links. It keeps installed software,
private configuration, caches, and unrelated files. It does not reset your
login shell or reverse macOS preferences.

Do not run `brew bundle cleanup --force` unless you intend to uninstall
software that is not listed in this repo.

## Migration

This cleanup does not uninstall software or delete files outside the repo.
Existing symlinks to removed files can now be dangling links.

Before setup:

1. Back up your current configuration.
2. Inspect these old links with `ls -ld`:
   - `~/.vimrc`
   - `~/.editorconfig`
   - `~/.config/fish/fishfile`
   - `~/.config/fish/fish_colors`
   - `~/.config/fish/completions`
   - Any links under `~/Library` that point into this repo's old `terminal/` directory.
3. Use `unlink` only for a symlink that points to a removed path in this repo.
   Do not delete real files or directories. Removing the old completions-directory
   link lets tools generate completions locally instead of writing into this repo.
4. Review old Fisherman-installed functions and plugins in
   `~/.config/fish/functions` and `conf.d`. Setup leaves those files alone.
   They can still affect your shell until you remove the ones you no longer use.
   Do not delete the whole Fish configuration directory.
5. Run `./setup.sh`.

The old global EditorConfig is now the repo's `.editorconfig`.
Use project-level EditorConfig files for other projects.

The generated Bun and pipx completions are no longer tracked. Regenerate them
with the corresponding tools if Fish's built-in completions are insufficient.

No Apple Terminal preferences or saved application state are imported.
Existing preferences remain on the machine. Ghostty and Zed use the tracked
text configuration described above.

## Checks

Install the Brewfile's check tools, then run:

```bash
./tests/run.sh
```

The checks use a temporary home directory. They verify syntax, setup conflicts,
repeatable setup, safe uninstall, Fish startup, Git configuration, and package
command construction. Package commands are mocked; the checks do not install
software or change the real home directory.

See [cleanup notes](docs/cleanup.md) for the release check and removed tools.
