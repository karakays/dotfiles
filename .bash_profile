#!/usr/bin/env bash

source ~/.bashrc

# run tmux from terminals only
PNAME="$(ps -o comm= $PPID)";
[ "$PNAME" == "gnome-terminal-" ] || \
    [[ "$PNAME" = *"iTerm2"* ]] && \
    command -v tmux>/dev/null && \
    [ -z $TMUX ] && tmux -f $TMUXCONF
