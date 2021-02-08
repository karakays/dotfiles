#!/usr/bin/env bash

source ~/.bashrc

# init scripts for login shells
for file in ~/.init.d/* ; do
    [ -f "$file" ] && source "$file"
done;

# run tmux from terminals only
PNAME="$(ps -o comm= $PPID)";
[ "$PNAME" == "gnome-terminal-" ] || \
    [[ "$PNAME" = *"iTerm2"* ]] || \
    [[ "$PNAME" = *"alacritty" ]] && \
    command -v tmux>/dev/null && \
    [ -z $TMUX ] && \
    tmux -f $TMUXCONF new-session -s init
