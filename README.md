# Vimux: basic configs of tmux and vim (For Linux)

## Vim config
```bash
cp -r vim ~/.vim
rm ~/.vimrc

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Tmux config
```bash
# Install Tmux
apt install tmux fzf ripgrep bat

cp -r tmux ~/.config/tmux
```

## Git config
```
cp git/gitconfig ~/.gitconfig

# Note: No need to set anymore
# Set global ignore pattern
# git config --global core.excludesfile ~/vimux/git/gitignore
# Set no pager in branch cmd
# git config --global pager.branch false
```

## Ctags config
```
# install exuberant-ctags
apt install exuberant-ctags
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
