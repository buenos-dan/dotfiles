# Personal dot files (On Mac)

## Do These Things To Quickly Setup My Dev Env.
### zsh config
```
cp zsh/zshrc ~/.zshrc
sudo ln -s zsh/zettlekasten.sh /usr/local/bin/zk

brew install ripgrep fzf bat

```

### Vim config
```bash
rm -rf ~/.vim
cp -r vim ~/.vim
rm ~/.vimrc

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install Plugin(open vim first)
:PlugInstall

# [opt] Install coc-pyright
:CocInstall coc-pyright
```

### Tmux config
```bash
cp -r tmux ~/.config/tmux
```

### Git config
```
cp git/gitconfig ~/.gitconfig

# [opt] Set global ignore pattern
git config --global core.excludesfile git/gitignore
```

## Do These Things If You Like.
### Ctags config
```
# install exuberant-ctags
apt install exuberant-ctags
cp ctag/ctags ~/.ctags

# create ctag file
cd <your code_ws>
ctags
```

### Install 256color-xterm
```
# 1. check term color support
echo $TERM
# xterm supports 8bit color
# xterm-256color supports 256bit color

# 2. Use 256 color xterm
echo "export TERM=xterm-256color" >> ~/.bashrc
source ~/.bashrc
```


## Other QA
1. how to delete swp file recursively?
`find ./ -name *.swp -type f -delete`
