#!/usr/bin/env bash

#  #A4B3B6  #D1E8E2  #88BDBC
#  #65CCB8  #3AAFA9  #116466
#  #254E58  #2C3531  #112D32
#  #3C6334  #61892F  #86C232
#  #FFCB9A  #D9B08C  #F16635

#     歷     <|> 華

monitor=${1:-0}
tags=( $(herbstclient tag_status $monitor) )
separator=""
for i in ${tags[@]} ; do
  case ${i:1} in
    '1')
      icon="  "
      ;;
    '2')
      icon="  "
      ;;
    '3')
      icon="  "
      ;;
    '4')
      icon="  "
      ;;
    '5')
      icon=" 歷 "
      ;;
    '7')
      icon="  "
      ;;
    '8')
      icon="  "
      ;;
    '9')
      icon="  "
      ;;
    '10')
      icon="  "
      ;;
    *)
      icon=" 華 "
      ;;
  esac
  case ${i:0:1} in
#    . the tag is empty
#    : the tag is not empty
#    + the tag is viewed on the specified MONITOR, but this monitor is not focused.
#    # the tag is viewed on the specified MONITOR and it is focused.
#    - the tag is viewed on a different MONITOR, but this monitor is not focused.
#    % the tag is viewed on a different MONITOR and it is focused.
#    ! the tag contains an urgent window
    '.')
      echo -n "%{B-}%{F-}%{A1:herbstclient focus_monitor $monitor && herbstclient us '${i:1}':} $icon %{A}%{F-}%{B-}"
      ;;
    ':')
      echo -n "%{B#0C0032}%{F-}%{A1:herbstclient focus_monitor $monitor && herbstclient use '${i:1}':} $icon %{A}%{F-}%{B-}"
      ;;
    '+')
      echo -n "%{B#190061}%{F-}%{A1:herbstclient focus_monitor $monitor && herbstclient use '${i:1}':} $icon %{A}%{F-}%{B-}"
      ;;
    '#')
      echo -n "%{B#E67580}%{F#FFFFFF}%{A1:herbstclient focus_monitor $monitor && herbstclient use '${i:1}':} $icon %{A}%{F-}%{B-}"
      ;;
    '-' | '%')
      echo -n "%{B#75B9E6}%{F-}%{A1:herbstclient focus_monitor $monitor && herbstclient use '${i:1}':} $icon %{A}%{F-}%{B-}"
      ;;
#    '%')
#      echo -n "%{B#240090}%{F-}%{A1:herbstclient focus_monitor $monitor && herbstclient use '${i:1}':} $icon %{A}%{F-}%{B-}"
#      ;;
    '!')
      echo -n "%{B-}%{F-}%{A1:herbstclient focus_monitor $monitor && herbstclient use '${i:1}':} $icon %{A}%{F-}%{B-}"
      ;;
    *)
      echo -n "%{B-}%{F-}%{A1:herbstclient focus_monitor $monitor && herbstclient use '${i:1}':} $icon %{A}%{F-}%{B-}"
      ;;
  esac
  #echo -n $separator
done
