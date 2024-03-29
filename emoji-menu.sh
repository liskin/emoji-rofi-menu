#!/usr/bin/env bash

set -eu

cd "$(dirname "$(readlink -f "$0")")"

# use https://github.com/liskin/dotfiles/blob/home/bin/rofi-dmenu-frece if available
if command -v rofi-dmenu-frece &>/dev/null; then
	function rofi-dmenu {
		rofi-dmenu-frece --db emoji-frece.db -- "$@"
	}
else
	function rofi-dmenu {
		rofi -dmenu "$@"
	}
fi

read -r emoji desc < <(rofi-dmenu -i -p "emoji" -font "${EMOJI_FONT:-mono} 20" -theme-str 'window {width: 80%;}' <emoji-data)
[[ $emoji && $desc ]]

# wait for focus to return back from rofi
sleep 0.2

xdotool type --clearmodifiers --delay 0 "$emoji"
xclip -rmlastnl <<<"$emoji"
