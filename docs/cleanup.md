# Dotfiles cleanup

Audit date: 2026-11-08 UTC.

## Scope

This pass changes the repo only. It does not install, upgrade, or uninstall
software on the Mac. Existing Fish and Git files are symlinked into the repo,
so their configuration changes apply to new sessions.

The separate Claude tmux worktree is unchanged. Credentials under `notable/`
and local agent files are ignored. Their contents were not read or committed.

A backup of the original tracked files, pending diff, and generated completions
is stored outside the repo at:

```text
~/.local/state/dotfiles-backups/20261108T054719Z
```

That backup includes the pending Vim changes removed by this cleanup.
It does not contain the untracked credential files or the separate worktree.

## Release check

The requested age limit applies to this cleanup only. Releases published after
2026-11-01 05:47 UTC were too new when checked.

| Tool | Newest eligible stable release | Published (UTC) | Repo change |
| --- | --- | --- | --- |
| asdf | 0.20.2 | 2026-09-22 | Replace the 0.11.3 Git checkout pin with the supported Homebrew formula. |
| Fish | 4.9.3 | 2026-09-08 | Keep the supported Homebrew formula. |
| Zed | 1.26.2 | 2026-10-28 | Replace Vim editor settings. Add the stable Homebrew cask. |

Zed 1.27.0 was published on 2026-11-04. It was too new for this cleanup.
No Zed version was installed or changed.

Primary sources:

- [asdf releases](https://github.com/asdf-vm/asdf/releases)
- [Fish releases](https://github.com/fish-shell/fish-shell/releases)
- [Zed releases](https://github.com/zed-industries/zed/releases)
- [asdf setup](https://asdf-vm.com/guide/getting-started.html)
- [asdf migration](https://asdf-vm.com/guide/upgrading-to-v0-16.html)

The repo no longer pins asdf, global Python runtimes, or plugin downloads.
Python 2.7.16, Python 3.7.4, and the Pipenv Python 3.6 default were removed,
not replaced with new global project requirements. The machine's existing
home-level Python 3.12.0 selection is outside this repo and was left unchanged.

All 45 Brewfile package names were checked against Homebrew metadata.
None were marked deprecated or disabled when checked.

The Brewfile is intentionally not a version lockfile. A future installation
uses Homebrew's then-current stable packages, including releases less than
seven days old. The scripts do not enforce a continuing age limit. This
repo-only pass does not claim that installed packages were updated.

## Removed setup and configuration

- Vim and MacVim, vim-plug, YouCompleteMe, and Vim-specific tests.
- PlanGrid environment variables and server shortcuts.
- Terminal preference binaries, saved sessions, and automatic preference imports.
- Fisherman and its old plugin list. Fish uses built-in defaults instead.
- Hand-maintained asdf completions and generated Bun/pipx completions.
- Old global Python and Pipenv defaults, Python 2 tooling, the old Poetry installer,
  and overlapping PyPy/pyenv setup.
- Docker Machine, Go dep, googler, neofetch, and the old Heroku setup.
- youtube-dl, replaced by yt-dlp.
- legit and its Git aliases. Git's built-in `switch` is no longer shadowed.
- Novelty-tool installs and aliases for removed tools.
- Homebrew auto-upgrade scheduling and obsolete taps.
- Destructive uninstall commands and automatic macOS changes.
- Old tests that depended on Python 2, Vundle, Intel-only paths, and live Vim processes.

These removals affect the repo, not installed packages.

## Preserved and corrected local changes

- Rectangle installation, now declared in the Brewfile.
- The Kubernetes `k` shortcut, now with argument forwarding.
- Public Git identity, signing-key ID, Git LFS, and GitHub CLI credentials.
- The existing global ignore for Claude's local settings.
- Local binary, Bun, pnpm, and Google Cloud paths.
- The existing Claude Code Vertex backend.
- Apple Silicon support, with Intel support retained.

The pnpm PATH now points at `PNPM_HOME`, not `PNPM_HOME/bin`.
Git and Fish use `zed --wait`.
Optional shell integrations are guarded so a missing tool does not print errors.

## History evidence and limits

Only command-name counts were inspected. Arguments and raw command lines were
not copied into the report. Fish history contained 2,377 entries, spanning
2023-04-15 through 2026-11-08 UTC.

Recent entries supported keeping Zed, Git, Google Cloud, Kubernetes, pnpm,
tmux, and autojump. Lack of a direct history entry was not treated as proof
that a tool was unused. Supported tools can also run through scripts,
shell integrations, and other programs.

## Follow-up on the Mac

- Follow the README migration steps for old links and Fisherman files.
- Migrate the old asdf installation before removing its checkout.
- Review old installed tools separately before uninstalling them.
- Disable any existing Homebrew autoupdate job if you no longer want it.
  Removing the installer does not stop a job already running on the Mac.
- Removing the old macOS commands does not reverse settings previously applied.
  Review disk-image verification, backup, and power settings separately.
