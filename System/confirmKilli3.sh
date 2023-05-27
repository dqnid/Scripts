#!/bin/bash
confirm="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '¿Cerrar ventana?' -width 12 -line-padding 3 -lines 3 -theme /home/danih/Scripts/rofi/confirm_kill.rasi <<< "No|Si")"
case "$confirm" in
	Si)
		echo "Si confirmado"
		i3-msg kill
		;;
esac
