dotfiles
===================
Modified version of mscoutermash's dotfiles
Big thanks to him!

## Installation

```
$ cd ~
$ git clone https://github.com/mscoutermarsh/dotfiles
```

```
$ brew tap thoughtbot/formulae
$ brew install rcm
```

Run rcm (this command expects that you cloned your dotfiles to `~/dotfiles/`)
```
$ env RCRC=$HOME/dotfiles/rcrc rcup
```
RCM creates dotfile symlinks (`.vimrc` -> `/dotfiles/vimrc`) from your home directory to your `/dotfiles/` directory.

#### Custom Fonts
You'll need to use a custom font for Airline to look nice. (Seeing weird symbols? This is why!). See here: https://github.com/Lokaltog/powerline-fonts
I use sourcecode pro. Once installed, go into iterm2 and Profiles > Text. Change both fonts.

### Recommended

**iterm2**
Use iterm2 instead of Terminal: http://iterm2.com/

There are two themes available for iterm2 inside this repository. Both solarized dark and light (to match vim!) Take a look at the `iterm2` directory.

**Oh-My-ZSH!**
I use Oh-My-ZSH instead of Bash. Info & installation instructions here: https://github.com/robbyrussell/oh-my-zsh

**Tmux**
```
$ brew install tmux
$ brew install reattach-to-user-namespace
```
