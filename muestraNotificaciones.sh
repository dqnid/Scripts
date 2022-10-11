#!/bin/bash
var=$(dunstctl history | sed -n /summary/,/}\,/p | grep data | awk '{$1=$2=""; print $0}' | sed 's/"//g')
echo $var
ver="$(rofi -no-config -no-lazy-grab -sep "\n" -dmenu -i -p 'Historial' -width 12 -line-padding 3 -lines 3 -theme ~/Scripts/Temas/notificaciones.rasi <<< "$var")"
