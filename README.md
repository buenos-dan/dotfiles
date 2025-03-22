# Personal dot files (For Linux)

## Bash config
```
apt install tmux fzf stow ripgrep
```

## Using stow to manage dotfiles
```
stow --dotfiles .
```

## Vim config
```bash
# Install nodejs: https://nodejs.org/en/download/
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# close terminal and reopen it.
nvm install 22

# Install Plugins
:PlugInstall

# Install coc-pyright
:CocInstall coc-pyright coc-lists
```
