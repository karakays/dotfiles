#!/usr/bin/env bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

for file in ~/.bashrc.d/.* ; do
    [ -f "$file" ] && echo running "$file" && source "$file";
done;

