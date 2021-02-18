#!/usr/bin/env bash

# init scripts for login shells
for file in ~/.init.d/* ; do
    [ -f "$file" ] && source "$file"
done;

