# dotfiles
My dotfiles, some of which are borrowed from https://github.com/mscoutermarsh/dotfiles.

You have to do these things in order:

If you use MacOS:

1) Install iTerm
2) Install https://github.com/Lokaltog/powerline-fonts. I use cousine for powerline
3) Install tmux
4) Install Xcode full version
5) Install macvim --with-override-system-vim
6) Install Node.js
7) Install zsh
8) Install oh-my-zsh
9) Install Exuberant Ctags with brew
10) Install import-js globally
11) `git clone https://github.com/ivangeorgiew/dotfiles.git ~/dotfiles`
12) `cd ~/dotfiles`
13) If you want to remove any of the plugins in vim/bundle DO IT NOW
14) `git submodule update --init --recursive`
15) `./install`
16) Follow the YouCompleteMe build instructions: https://github.com/Valloric/YouCompleteMe#full-installation-guide
17) Update stuff you want to update
18) Add .vim/undo and .vim/session folders

If you use ArchLinux:
1) Install https://github.com/Lokaltog/powerline-fonts. I use cousine for powerline
2) pacman install gvim
3) Install Node.js
4) Install zsh
5) Install oh-my-zsh
6) Install Exuberant Ctags with brew
10) Install import-js globally
11) `git clone https://github.com/ivangeorgiew/dotfiles.git ~/dotfiles`
12) `cd ~/dotfiles`
13) If you want to remove any of the plugins in vim/bundle DO IT NOW
14) `git submodule update --init --recursive`
15) `./install`
16) Follow the YouCompleteMe build instructions: https://github.com/Valloric/YouCompleteMe#full-installation-guide
17) Update stuff you want to update
18) Add .vim/undo and .vim/session folders
