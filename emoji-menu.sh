#!/usr/bin/env bash

set -eu

cd "$(dirname "$(readlink -f "$0")")"

IFS=$'\t' read -r emoji_desc key < <(rofi -dmenu -i -p "emoji" <emoji-data)
read -r <<<"$emoji_desc" emoji desc
[[ $emoji && $desc && $key ]]

xdotool key "$key"
if command -v xsel >/dev/null; then
	echo -n "$emoji" | xsel -i -p
	echo -n "$emoji" | xsel -i -b
elif command -v xclip >/dev/null; then
	echo -n "$emoji" | xclip -i -sel prim
	echo -n "$emoji" | xclip -i -sel clip
fi
