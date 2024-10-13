#!/bin/bash

session="devbox"
gravity_dir="/mlx_devbox/users/danmingdi.buenos/repo/Gravity"
nn_practice_dir="/root/Neural-Network-Hands-On-Practice"

tmux has-session -t=${session} 2>/dev/null

if [ $? -eq 0 ]
then
    tmux attach-session -t=${session}
    exit 0
fi

tmux start-server
tmux new-session -d -s ${session}

# Open gravity project in window1
tmux rename-window "Gravity"
tmux send-keys "cd ${gravity_dir}" C-m
if [ -f "${gravity_dir}/Session.vim" ]; then
    tmux send-keys "vim -S Session.vim" C-m
else
    tmux send-keys "vim ." C-m
fi

# Open gravity project in window2
tmux new-window -a -t=${session}
tmux select-window -t:1
tmux rename-window "NN-Practice"
tmux send-keys "cd ${nn_practice_dir}" C-m
if [ -f "${nn_practice_dir}/Session.vim" ]; then
    tmux send-keys "vim -S Session.vim" C-m
else
    tmux send-keys "vim ." C-m
fi

tmux select-window -t:0
tmux attach-session -t ${session}
