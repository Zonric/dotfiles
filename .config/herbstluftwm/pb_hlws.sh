#!/usr/bin/env bash

source ~/.config/herbstluftwm/themes/active_colors

fcolor() {
	echo -n "%{F$1}"
}
onclick() {
	echo -n "%{A1:herbstclient focus_monitor $1 && herbstclient use '$2':}"
}

monitor=${1:-0}
tags=( $(herbstclient tag_status $monitor) )
separator=""
for i in ${tags[@]} ; do
	case ${i:1} in
		# --- ICONS:					歷 	󰕃	󰙯				 既 <|>  華
		'1')	icon="󱃖" ;;
		'2')	icon="" ;;
		'3')	icon="" ;;
		'4')	icon="" ;;
		'5')	icon="" ;;
		'6')	icon="" ;;
		'7')	icon="" ;;
		'8')	icon="󰓇" ;;
		'9')	icon="󰙯" ;;
		'10') icon="" ;;
		'scratchpad') icon="" ;;
		'sysadmin') icon="" ;;
		'audio') icon="" ;;
		*)		icon="華";;
	esac
	case ${i:0:1} in
		# --- Colors: gary [444444] white [ffffff] light green [66ff66] darkgreen [119966] light teal [33CCFF] dark teal [669999] yellow [FF00FF]
		# --- Tag is not displayed on a monitor
		'.') # EMPTY (Dark Gray) [444444]
			fcolor $FOREGROUND_ALT
			onclick $monitor ${i:1}
			echo -n " $icon %{A}"
		;;
		':') # NOT EMPTY (White) [FFFFFF]
			fcolor $FOREGROUND
			onclick $monitor ${i:1}
			echo -n " $icon %{A}"
		;;

		# --- Tag is viewed on specified MONITOR
		'#') # Focused.
			fcolor $ACTIVE
			onclick $monitor ${i:1}
			echo -n " $icon %{A}"
		;;
		'+') # NOT focused
			fcolor $ACTIVE_ALT
			onclick $monitor ${i:1}
			echo -n " $icon %{A}"
		;;

		# --- Tag is viewed on different monitor
		'%') # and is FOCUSED (Light Blue Teal) [33CCFF]
			fcolor $ACTIVE
			onclick $monitor ${i:1}
			echo -n " $icon %{A}"
		;;
		'-') # and is NOT focused (Dark Blue/Dark Teal) [669999]
			fcolor $ACTIVE_ALT
			onclick $monitor ${i:1}
			echo -n " $icon %{A}"
		;;

		# --- Tag contains Urgent Window!
		'!')
			fcolor $URGENT
			onclick $monitor ${i:1}
			echo -n " $icon %{A}"
		;;

		# --- Somethins gone wrong... Set font yellow			
		*)
			fcolor $ERROR
			onclick $monitor ${i:1}
			echo -n " $icon %{A}"
		;;
	esac
done
