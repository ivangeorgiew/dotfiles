# dotfiles
My dotfiles, some of which are borrowed from https://github.com/mscoutermarsh/dotfiles.

You have to do these things in order:

1) Install iTerm
2) Install tmux
3) Install Node.js
4) Install zsh
5) Install oh-my-zsh
6) Configure oh-my-zsh theme
7) Install https://github.com/Lokaltog/powerline-fonts. I use cousine for powerline
8) Install macvim --with-override-system-vim
9) Install Exuberant Ctags with brew
10) Install import-js from my fork(in case they haven't fixed the bugs)
10) Make all files symbolic links: cd ~/dotfiles | ./install.sh
11) Inside .vim/bundle (where necessary): git submodule update --init --recursive
12) Follow the YouCompleteMe installation instructions
13) Update stuff you want to update
