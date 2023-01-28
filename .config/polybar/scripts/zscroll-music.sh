#!/usr/bin/env sh

zscroll -l 20 -d 0.15 -p ' 󰎈󰎈󰎈󰎈󰎈 ' -M "`dirname $0`/music.sh --scroll" -m "Playing" "--scroll 1" -m "Paused" "--scroll 0" --update-check true "`dirname $0`/music.sh" &

wait
