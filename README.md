These are my dotfiles. They are quite specific to my needs, but hopefully you
will find a thing or three of use here.

### Install

To install, `cd` into this directory and run `./install.sh` with one or more
of the following switches:

* `-c`: Symlink common dotfiles such as .gitconfig and .vimrc.
* `-l`: Symlink local-only dotfiles such as .xmodmaprc and terminalrc.
* `-r`: Symlink remote-only dotfiles such as .screenrc.

On Windows, symlinks for .gitconfig and .hgrc can be created by running
`win-install.bat` with administrative rights.

### Credits

* [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [spf13/spf13-vim](https://github.com/spf13/spf13-vim)