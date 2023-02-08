#!/usr/bin/env bash
session=${1:-herbstluftwm}

export CFG_WM_BAR=none
export CFG_WM_SXHKD=false

case $session in
  bsp | bspwm )
    export CFG_WM=bspwm
    export CFG_WM_CMD=bspwm
    export CFG_WM_BAR=polybar
    export CFG_WM_SXHKD=true
  ;;
  hl|hlwm|herb|herbs|herbstluft|herbstluftwm)
    export CFG_WM=herbstluftwm
    export CFG_WM_CMD=herbstluftwm
    export CFG_WM_BAR=polybar
    export CFG_WM_SXHKD=false
  ;;
  i3 | i3wm )
    export CFG_WM=i3
    export CFG_WM_CMD=i3
    export CFG_WM_BAR=polybar
    export CFG_WM_SXHKD=true
  ;;
  notion)
    export CFG_WM=notion
    export CFG_WM_CMD=notion
  ;;
  spectr | spectrwm )
    export CFG_WM=spectrwm
    export CFG_WM_CMD=spectrwm
    export CFG_WM_BAR=polybar
    export CFG_WM_SXHKD=true
  ;;
  xf | xfce | xfce4 )
    export CFG_WM=xfce4
    export CFG_WM_CMD=startxfce4
  ;;
  qtile | qt)
    export CFG_WM=qtile
    export CFG_WM_CMD=qtile start
  ;;
  * )
    export CFG_WM_CMD=$session
  ;;
esac

source ~/.xprofile
exec $CFG_WM_CMD
