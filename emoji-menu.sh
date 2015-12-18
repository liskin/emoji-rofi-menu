#!/usr/bin/env bash

cd $(dirname $(readlink -f $0))

line=$(cat emoji-data | rofi -dmenu)
if [ ! -z "$line" ]; then
    xdotool key $(cut -f 2 <<< "$line" )
fi
