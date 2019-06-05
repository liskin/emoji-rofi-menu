#!/usr/bin/env bash

set -eu

cd "$(dirname "$(readlink -f "$0")")"

read -r emoji desc < <(rofi -dmenu -i -p "emoji" -font "mono 20" -width 80 <emoji-data)
[[ $emoji && $desc ]]

xdotool type "$emoji"
