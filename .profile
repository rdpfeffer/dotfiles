# Use personal aliases

source ~/.aliases

set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_display_git_untracked no
set -g theme_color_scheme solarized-dark

if status --is-login

    # better ls colors
    set -gx LSCOLORS gxfxcxdxbxegedabagacad

    set -gx PATH /usr/local/bin $PATH
    set -gx GOPATH ~/go/

    # Autojump support
    [ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

    # Don't write bytecode, Python!
    export PYTHONDONTWRITEBYTECODE=1
    export PIPENV_DEFAULT_PYTHON_VERSION=3.6
    export PIPENV_SHELL_FANCY=1
    export PIPENV_MAX_SUBPROCESS=32
    export EDITOR=subl
    set SHELL /usr/local/bin/fish

    set -gx PATH /Users/kennethreitz/.local/bin $PATH
    set -gx PATH /usr/local/opt/python@2/bin $PATH
    set -gx ANDROID_NDK_HOME /usr/local/share/android-ndk
    set -gx ANDROID_SDK_ROOT /usr/local/share/android-sdk

    # Go support.
    set -gx PATH /Users/kennethreitz/go/bin $PATH

    # set -x PYENV_ROOT $HOME/.pyenv
    # set -x PATH $PYENV_ROOT/bin $PATH
end

export GPG_TTY=(tty)
