#!/bin/zsh

VAULT_PATH="${HOME}/Zettelkasten"
cd ${VAULT_PATH}

filename=$(fd --extension md --exclude template --exclude Excalidraw | fzf)
vim --cmd 'let g:loaded_zettelkasten=1' ${filename}
