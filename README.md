# Personal dot files (For Linux)

## Bash config
```
apt install tmux fzf ripgrep bat exuberant-ctags

```

## Vim config
```bash
rm -rf ~/.vim
cp -r vim ~/.vim
rm ~/.vimrc

# Install nodejs
# Ref: https://nodejs.org/en/download/
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# close terminal and reopen it.
nvm install 22

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install Plugins
:PlugInstall

# Install coc-pyright
:CocInstall coc-pyright coc-lists
```

## Tmux config
```bash
cp -r tmux ~/.config/tmux
```

## Git config
```
cp git/gitconfig ~/.gitconfig

# Note: No need to set anymore
# Set global ignore pattern
cp -r git ~/.config
git config --global core.excludesfile ~/.config/git/gitignore
# Set no pager in branch cmd
# git config --global pager.branch false
```

## Ctags config
```
cp ctag/ctags ~/.ctags

# create ctag file
cd <your code_ws>
ctags
```

## Install 256color-xterm
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
