#!/usr/bin/env bash

source ~/.bashrc

PNAME="$(ps -o comm= $PPID)";

# run tmux from terminals only
[ "$PNAME" == "gnome-terminal-" ] || \
    [[ "$PNAME" = *"iTerm2"* ]] && \
    command -v tmux>/dev/null && \
    [ -z $TMUX ] && tmux -f $TMUXCONF
