# Ryan Pfeffer's Dotfiles


## What
Simple tools working together to create a delightful development environment.

 * VIM - for text editing, code refactoring, etc
 * [Fish Shell](https://fishshell.com) - for a shell, plus fisherman for plugin management.
 * [direnv](https://direnv.net) - To manage project specific env vars (and keep config clean).
 * [GNU stow](https://www.gnu.org/software/stow/) stow to [manage config and rc files](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html) 
 * [Spectacle](https://www.spectacleapp.com/) for window management (I'm not into tmux...yet).

## Bootstrap
From a totally clean environment, run...

```bash
$ source <(curl -fsSL https://raw.githubusercontent.com/rdpfeffer/dotfiles/master/install.sh)
$ ./install.sh | ./update.sh
```

## Setup
A few things will need to be manually configured, (keys setup etc) before everything is good to go.

 1. Setup [ssh access to github](https://help.github.com/articles/connecting-to-github-with-ssh/)
 1. Setup [GPG keys for commit signing](https://help.github.com/articles/signing-commits-with-gpg/)
 1. Clone this repo, and run...

```bash
$ cd ~
$ git clone git@github.com:rdpfeffer/dotfiles.git
$ cd dotfiles
$ ./setup.sh
```

### Useful MacOS Utilities

    $ battery
    <displays battery state>

    $ cpu
    Intel(R) Core(TM) i7-5557U CPU @ 3.10GHz

    $ lock
    (locks screen)

### Generally Useful Utilities

    $ up
    PING 8.8.8.8 (8.8.8.8): 56 data bytes
    64 bytes from 8.8.8.8: icmp_seq=0 ttl=58 time=23.997 ms

    $ cake
    Copied! ✨ 🍰 ✨

    $ super-cake
    Copied! 💫 ✨ 🍰 ✨ 💫

    $ pyc
    <removes all .pyc files from current working directory and subdirs>
