#!/usr/bin/env sh

source ~/.config/herbstluftwm/color_scheme/active

fcolor() {
	echo -n "%{F$1}"
}
onclick() {
	echo -n "%{A1:herbstclient focus_monitor $1 && herbstclient use '$2':}"
}

monitor=${1:-0}
displaytitle=${2:-0}
displayother=${3:-0}
displayempty=${4:-0}
tags=( $(herbstclient tag_status $monitor) )
separator=""
for i in ${tags[@]} ; do
	case ${i:1} in
###---   ICONS:         	 	歷   	󰕃 	󰙯 	 	 	 	 既    華󱁴
		"1") title=" 1:" icon="󰅱" ;;
		"2") title=" 2:" icon="" ;;
		"3") title=" 3:" icon="" ;;
		"4") title=" 4:" icon="" ;;
		"5") title=" 5:" icon="" ;;
		"6") title=" 6:" icon="󱁴" ;;
		"7") title=" 7:" icon="" ;;
		"8") title=" 8:" icon="" ;;
		"9") title=" 9:" icon="󱆗" ;;
		"10") title=" 0:" icon="" ;;
		"audio") title=" -:" icon="" ;;
		"scratchpad") title=" =:" icon="" ;;
		"sysadmin") title=" ~:" icon="" ;;
		*) title=" ?:" icon="華";;
	esac
	case ${i:0:1} in
		# --- Tag is not displayed on a monitor
		'.') # EMPTY
			fcolor $FOREGROUND_ALT
			onclick $monitor ${i:1}
			if [[ displayempty -gt 0 ]]; then
				if [[ displaytitle -gt 0 ]]; then
					echo -n "$title"
				fi
				echo -n "$icon %{A}"
			fi
		;;
		':') # NOT EMPTY
			fcolor $FOREGROUND
			onclick $monitor ${i:1}
			if [[ displaytitle -gt 0 ]]; then
				echo -n "$title"
			fi
			echo -n "$icon %{A}"
		;;
		# --- Tag is viewed on specified MONITOR
		'#') # Focused.
			fcolor $ACTIVE
			onclick $monitor ${i:1}
			if [[ displaytitle -gt 0 ]]; then
				echo -n "$title"
			fi
			echo -n "$icon %{A}"
		;;
		'+') # NOT focused
			fcolor $ACTIVE_ALT
			onclick $monitor ${i:1}
			if [[ displaytitle -gt 0 ]]; then
				echo -n "$title"
			fi
			echo -n "$icon %{A}"
		;;
		# --- Tag is viewed on different monitor
		'%') # and is FOCUSED
			fcolor $ACTIVE
			onclick $monitor ${i:1}
			if [[ displayother -gt 0 ]]; then
				if [[ displaytitle -gt 0 ]]; then
					echo -n "$title"
				fi
				echo -n "$icon %{A}"
			fi
		;;
		'-') # and is NOT focused
			fcolor $ACTIVE_ALT
			onclick $monitor ${i:1}
			if [[ displayother -gt 0 ]]; then
				if [[ displaytitle -gt 0 ]]; then
					echo -n "$title"
				fi
				echo -n "$icon %{A}"
			fi
		;;
		# --- Tag contains Urgent Window!
		'!')
			fcolor $URGENT
			onclick $monitor ${i:1}
			if [[ displaytitle -gt 0 ]]; then
				echo -n "$title"
			fi
			echo -n "$icon %{A}"
		;;
		# --- Somethins gone wrong...
		*)
			fcolor $ERROR
			onclick $monitor ${i:1}
			if [[ displaytitle -gt 0 ]]; then
				echo -n "$title"
			fi
			echo -n "$icon %{A}"
		;;
	esac
done
