#!/usr/bin/env sh

xrandr \
  --output DisplayPort-1 --mode 1920x1080 --rate 144.00 --pos 0x0 --rotate normal \
  --output DisplayPort-0 --mode 3440x1440 --rate 144.00 --right-of DisplayPort-1 --rotate normal --primary \
  --output DisplayPort-2 --mode 1920x1080 --rate 144.00 --right-of DisplayPort-0 --rotate normal

