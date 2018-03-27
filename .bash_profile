#!/usr/bin/env bash

# $HOME/.bash_profle

for file in ~/.{aliases,exports,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

[ -f ~/.local/bin/git-complete ] && source ~/.local/bin/git-complete

[ -f ~/.psql/.pghosts ] && source ~/.psql/.pghosts

if command -v tmux>/dev/null; then
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux -f $TMUXCONF
fi
