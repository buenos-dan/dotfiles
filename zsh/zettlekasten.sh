#!/bin/zsh

VAULT_PATH="${HOME}/Zettelkasten"

cd ${VAULT_PATH}
if [ ! -z $1 ]; then
    read filename line <<< `rg -S -n -m 1 $1 | awk -F : 'NR==1 {print $1, $2}'`
    if [ ! -z ${filename} -a -f ${filename} ]; then
        vim --cmd 'let g:loaded_zettelkasten=1' +${line} ${filename}
        exit 0
    fi
fi

vim --cmd 'let g:loaded_zettelkasten=1' -c 'RandomOpenFleetingNote' -c 'Rg'
