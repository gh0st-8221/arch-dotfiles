#!/usr/bin/env bash

multiple="$1"
directory="$2"
save="$3"
path="$4"
out="$5"

start_dir=""
if [ -n "$path" ] && [ -d "$path" ]; then
    start_dir="$path"
elif [ -n "$path" ] && [ -f "$path" ]; then
    start_dir="$(dirname "$path")"
fi

tmp="$(mktemp)"

if [ -n "$start_dir" ]; then
    alacritty -e yazi --chooser-file="$tmp" "$start_dir"
else
    alacritty -e yazi --chooser-file="$tmp"
fi

if [ -s "$tmp" ]; then
    cat "$tmp" > "$out"
else
    rm -f "$tmp"
    exit 1
fi

rm -f "$tmp"
