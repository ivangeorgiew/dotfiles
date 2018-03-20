# dotfiles
My dotfiles, some of which are borrowed from https://github.com/mscoutermarsh/dotfiles.

You have to do these things in order:

If you use ArchLinux:
1) Install Antergos base
2) Identify your video card and install the corresponding drivers: `lspci | grep -e VGA -e 3D`
3) CHOOSE ONE: `pacman -S nvidia` OR `pacman -S xf86-video-ati` OR `pacman -S xf86-video-intel`
4) Change the username in settings/autologin@.service file
5) `~/dotfiles/archScript`
6) `~/dotfiles/install`
7) `cd ~ && git clone https://github.com/powerline/fonts.git --depth=1`
8) `cd fonts && ./install.sh`
9) `rm -fr fonts`
10) `sudo reboot`
11) `mkdir ~/.npm-global && npm config set prefix '~/.npm-global'`
12) `npm i -g import-js`
14) Configure lxappearance
15) `cd ~/dotfiles/.vim/bundle && git submodule update --init --recursive`
16) Follow the YouCompleteMe build instructions: https://github.com/Valloric/YouCompleteMe#full-installation-guide

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
