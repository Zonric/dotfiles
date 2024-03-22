#!/usr/bin/env bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do
  sleep 1; done

polybar primary -r 2>/dev/null &
polybar mon_left -r 2>/dev/null &
polybar mon_right -r 2>/dev/null &
