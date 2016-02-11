Installation
============

Clone the repo:
`git clone https://github.com/lunks/vimfiles.git ~/.vim`

Grab vim-plug:
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Symlink everything so neovim finds it:
```
ln -s ~/.vim/vimrc ~/.vimrc`
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
```

Install plugins:
`nvim +PlugInstall +qall`
