#!/usr/bin/env sh
BAR_NAME="primary"
BAR_PID=$(pgrep -a "polybar" | grep "$BAR_NAME" | cut -d" " -f1)
PLAYER="spotify"
FORMAT="{{artist}} - {{title}}"

update() {
	while IFS= read -r id
	do
		polybar-msg -p "$id" hook music-pp $2 1>/dev/null 2>&1
	done < <(echo "$1")
}

PLAYER_STATUS=$(playerctl -p spotify status)

if [ "$1" == "--scroll" ]; then
	echo "$STATUS"
else
	if [ "$PLAYER_STATUS" = "Playing" ]; then
		update "$BAR_PID" 1
		playerctl --player=$PLAYER metadata --format "$FORMAT"
	elif [ "$PLAYER_STATUS" = "Paused" ]; then
		update "$BAR_PID" 2
		playerctl --player=$PLAYER metadata --format "$FORMAT"
	elif [ "$PLAYER_STATUS" = "No players found" ]; then
		echo "$PLAYER_STATUS"
	fi
fi
