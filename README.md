# Ryan Pfeffer's Dotfiles

Dotfiles are stored on github and managed using [GNU stow](https://www.gnu.org/software/stow/). See [this article](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html) for more info. 

    $ ./install.sh | ./update.sh

### Fish Shell

I use the [Fish Shell](https://fishshell.com). It's excellent software. I use [fisherman](https://github.com/fisherman/fisherman) to manage my shell plugins:

    $ fisher ls
    * metro	humanize_duration
      anicode	last_job_id
      bass	pipenv
      bd	pisces
      choices	pwd_info
      done	pwd_is_home
      get	pyenv
      getopts	segment
      git_util	spin
      grc	ssh-term-helper
      host_info
### Homebrew Packages
    
List of [installed packages](https://github.com/rdpfeffer/dotfiles/blob/master/install.sh).

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
