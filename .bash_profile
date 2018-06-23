#!/usr/bin/env bash

echo ".bash_profile running"

for file in ~/.{aliases,exports,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

[ -f ~/.local/bin/git-complete ] && source ~/.local/bin/git-complete

[ -f ~/.psql/.pghosts ] && source ~/.psql/.pghosts

PNAME="$(ps -o comm= $PPID)";

# exec tmux from terminal process only
[ "$PNAME" == "gnome-terminal-" ] && command -v tmux>/dev/null && [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux -f $TMUXCONF
