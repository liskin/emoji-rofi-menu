#!/usr/bin/env bash

set -eu

cd "$(dirname "$(readlink -f "$0")")"

read -r emoji desc < <(rofi -dmenu -i -p "emoji" -font "mono 20" -width 80 <emoji-data)
[[ $emoji && $desc ]]

# wait for focus to return back from rofi
sleep 0.2

xdotool type --clearmodifiers --delay 0 "$emoji"
xclip -rmlastnl <<<"$emoji"
