# Use personal aliases

source ~/.config/fish/aliases.fish


if status --is-login

    # Remove make from the list of executables that we will wrap with the grc
    # plugin as it will break terminal sessions with docker that happen to be
    # invoked with make. This must be a universal variable so that it can be
    # picked up by the init script which is loaded before this one. (NOTE:
    # this also means that the very first terminal session will not be able to
    # use make in this way, but this is an edge case I'm willing to live with
    # for now.)
    set -Ux grc_plugin_execs cat df diff dig gcc g++ ifconfig ls mount netstat ps ping tail traceroute wdiff

    set -gx PATH /usr/local/bin $PATH
    set -gx GOPATH ~/go

    # Autojump support
    [ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

    # Don't write bytecode, Python!
    set -gx PYTHONDONTWRITEBYTECODE 1
    set -gx PIPENV_DEFAULT_PYTHON_VERSION 3.6
    set -gx PIPENV_SHELL_FANCY 1
    set -gx PIPENV_MAX_SUBPROCESS 64
    set SHELL /usr/local/bin/fish

    # set -gx PATH /Users/rpfeffer/.local/bin $PATH
    set -gx PATH $HOME/.poetry/bin $PATH
    set -gx ANDROID_NDK_HOME /usr/local/share/android-ndk
    set -gx ANDROID_SDK_ROOT /usr/local/share/android-sdk

    # VIM!
    set -gx EDITOR vim

    # FZF should use ripgrep when searching for files. This will allow FZF to
    # show files that have not been added to the git index (which is especially
    # useful while using vim).
    set -gx FZF_DEFAULT_COMMAND 'rg --files'

    # remove the fish greeting
    set fish_greeting

    # Load other available profiles
    if test -d ~/.config/fish/profiles
        for profile in ~/.config/fish/profiles/*.fish
            source $profile
        end
    end

    # Add asdf support
    source ~/.asdf/asdf.fish

end

set GPG_TTY (tty)
