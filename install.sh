main () {
    rm -fr ~/.vim
    rm ~/.agignore ~/.ctags ~/.gitconfig ~/.gitignore ~/.importjs.js ~/.tern-config ~/.tmux.conf ~/.vimrc ~/.zprofile ~/.zshenv ~/.zshrc

    ln -s ~/dotfiles/.agignore ~/.agignore
    ln -s ~/dotfiles/.ctags ~/.ctags
    ln -s ~/dotfiles/.gitconfig ~/.gitconfig
    ln -s ~/dotfiles/.gitignore ~/.gitignore
    ln -s ~/dotfiles/.importjs.js ~/.importjs.js
    ln -s ~/dotfiles/.tern-config ~/.tern-config
    ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
    ln -s ~/dotfiles/.vim ~/.vim
    ln -s ~/dotfiles/.vimrc ~/.vimrc
    ln -s ~/dotfiles/.zprofile ~/.zprofile
    ln -s ~/dotfiles/.zshenv ~/.zshenv
    ln -s ~/dotfiles/.zshrc ~/.zshrc
}

main
