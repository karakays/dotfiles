#!/usr/bin/env bash

# $HOME/.bash_profle

for file in ~/.{aliases,exports,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

if [ -f ~/.local/bin/git-complete ]; then
	source ~/.local/bin/git-complete
fi

if [ -f ~/.psql/.pghosts ]; then
	source ~/.psql/.pghosts
fi

if command -v tmux>/dev/null; then
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux -f $TMUXCONF
fi
