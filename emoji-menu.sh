#!/usr/bin/env bash

set -eu

cd "$(dirname "$(readlink -f "$0")")"

IFS=$'\t' read -r emoji_desc key < <(rofi -dmenu -i -p "emoji" -font "mono 20" -width 80 <emoji-data)
read -r <<<"$emoji_desc" emoji desc
[[ $emoji && $desc && $key ]]

xdotool key "$key"
