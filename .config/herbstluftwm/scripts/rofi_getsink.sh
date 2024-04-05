#!/usr/bin/env sh
# shellcheck disable=SC2207,SC2068,SC2086,SC3024,SC3010,SC2059

hc() {
	herbstclient "$@"
}
MOD=Mod4

SINKS=($(pactl list short sinks | awk '{print $2}' | sed -e '/^alsa_/d'))
for SINK in ${SINKS[@]}; do
	OPTIONS+="$SINK\n"
done
CHOSEN=$(printf $OPTIONS | rofi -dmenu)

if [[ ${#CHOSEN} -lt 3 ]]; then
	notify-send "Sink selection cancelled."
	exit
fi

hc keybind $MOD+Up spawn pactl set-sink-volume $CHOSEN +5%
hc keybind $MOD+Down spawn pactl set-sink-volume $CHOSEN -5%

hc keybind XF86AudioMute spawn pactl set-sink-mute $CHOSEN toggle
hc keybind XF86AudioLowerVolume spawn pactl set-sink-volume $CHOSEN +5%
hc keybind XF86AudioRaiseVolume spawn pactl set-sink-volume $CHOSEN -5%
echo $CHOSEN > ~/.config/herbstluftwm/setsink
notify-send "Sink set to: $CHOSEN"

