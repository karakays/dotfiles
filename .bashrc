#!/usr/bin/env bash

for file in ~/.bashrc.d/.* ; do
    [ -f "$file" ] && [ -x "$file" ] && source "$file";
done;

