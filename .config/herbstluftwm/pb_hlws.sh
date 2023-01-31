#!/usr/bin/env sh

monitor=${1:-0}
tags=( $(herbstclient tag_status $monitor) )
separator=""
for i in ${tags[@]} ; do
  case ${i:1} in
# --- ICONS:          歷   󰕃  󰙯         既 <|>  華
    '1')  icon="" ;;
    '2')  icon="" ;;
    '3')  icon="" ;;
    '4')  icon="" ;;
    '5')  icon="" ;;
    '6')  icon="" ;;
    '7')  icon="" ;;
    '8')  icon="󰓇" ;;
    '9')  icon="󰙯" ;;
    '10') icon="" ;;
    'scratchpad') icon="" ;;
    *)    icon="華";;
  esac
  case ${i:0:1} in
# --- Colors: gary [444444] white [ffffff] light green [66ff66] darkgreen [119966] light teal [33CCFF] dark teal [669999] yellow [FF00FF]
# --- Tag is not displayed on a monitor
    '.') # EMPTY (Dark Gray) [444444]
      echo -n "%{B-}%{F#444444}%{A1:herbstclient focus_monitor $monitor && herbstclient use '${i:1}':} $icon %{A}" ;;
    ':') # NOT EMPTY (White) [FFFFFF]
      echo -n "%{B-}%{F#FFFFFF}%{A1:herbstclient focus_monitor $monitor && herbstclient use '${i:1}':} $icon %{A}" ;;

# --- Tag is viewed on specified MONITOR
    '#') # and is FOCUSED (Light Green) [66FF66]
      echo -n "%{B-}%{F#66FF66}%{A1:herbstclient focus_monitor $monitor && herbstclient use '${i:1}':} $icon %{A}" ;;
    '+') # and is NOT focused (Dark Green) [119966]
      echo -n "%{B-}%{F#119966}%{A1:herbstclient focus_monitor $monitor && herbstclient use '${i:1}':} $icon %{A}" ;;

# --- Tag is viewed on different monitor
    '%') # and is FOCUSED (Light Blue Teal) [33CCFF]
      echo -n "%{B-}%{F#33CCFF}%{A1:herbstclient focus_monitor $monitor && herbstclient use '${i:1}':} $icon %{A}" ;;
    '-') # and is NOT focused (Dark Blue/Dark Teal) [669999]
      echo -n "%{B-}%{F#669999}%{A1:herbstclient focus_monitor $monitor && herbstclient use '${i:1}':} $icon %{A}" ;;

# --- Tag contains Urgent Window!
    '!')
      echo -n "%{B#660000}%{F#FF00FF}%{A1:herbstclient focus_monitor $monitor && herbstclient use '${i:1}':} $icon %{A}" ;;

# --- Somethins gone wrong... Set font yellow      
    *)
      echo -n "%{B-}%{F#FFE135}%{A1:herbstclient focus_monitor $monitor && herbstclient use '${i:1}':} $icon %{A}%{F-}%{B-}" ;;
  esac
done
