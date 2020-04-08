#!/usr/bin/env bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# prepare environment for non-login sessions
for file in ~/.bashrc.d/.* ; do
    [ -f "$file" ] && source "$file"
done;

[ -f /etc/bash_completion ] && source /etc/bash_completion

command_not_found_handle1() {
    if cmd.exe /c "(where $1 || (help $1 |findstr /V Try)) >nul 2>nul && ($* || exit 0)"; then
        return $?
    else
        if [ -x /usr/lib/command-not-found ]; then
           /usr/lib/command-not-found -- "$1"
           return $?
        elif [ -x /usr/share/command-not-found/command-not-found ]; then
           /usr/share/command-not-found/command-not-found -- "$1"
           return $?
        else
           printf "%s: command not found\n" "$1" >&2
           return 127
        fi
    fi
}
