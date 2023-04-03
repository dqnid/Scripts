#!/bin/bash

# To-do: Add Eww widgets or other interface

theme="~/Scripts/Temas/"

server_routes=("Anotaciones" "Universidad/Segundo[[:space:]]Cuatrimestre/" "Universidad/TFG/")
local_full=("Documents/Anotaciones/" "Documents/Proyectos/" "Documents/Universidad/" "Images/Carteles[[:space:]]OZ/" "Images/Proyectos/")

dotfiles=(".bashrc" ".config/nvim/" ".config/polybar/" ".config/i3/" ".config/mpd/" ".config/ncmpcpp/" ".config/mpv/" ".config/nemo/" ".config/dunst/" ".config/glava/" ".config/ranger/" ".config/sxhkd/" ".config/picom.conf")


net="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'Network' -width 12 -line-padding 3 -lines 2 -theme /home/danih/Scripts/Temas/sinc.rasi <<< "LAN|WAN")"
case "$net" in
	LAN)
		operation="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'Action' -width 12 -line-padding 3 -lines 2 -theme /home/danih/Scripts/Temas/sinc.rasi <<< "PUSH|PULL")"
		case "$operation" in
			PUSH)
				origin="/home/danih/"
				dest="dqnid@192.168.0.109:/home/dqnid/"
				;;
			PULL)
				dest="/home/danih/"
				origin="dqnid@192.168.0.109:/home/dqnid/"
				;;
		esac
		files_to_sync="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'Files To Sync' -width 12 -line-padding 3 -lines 2 -theme /home/danih/Scripts/Temas/sinc.rasi <<< "Documents|Images|Videos|Music|Dotfiles|All")"
		case "$files_to_sync" in
			Documents | Images | Videos | Music)
				for dir in "$origin$files_to_sync"/*
					rsync -vrP -e "ssh -i ~/.ssh/id_rsa_dqnid" --delete-after $origin/$dir $dest/$dir
				;;
			Dotfiles)
				for i in "${dotfiles[@]}"
				do
					rsync -vrP -e "ssh -i ~/.ssh/id_rsa_dqnid" --delete-after $origin/$i $dest/$i
					if test $? -eq 0; then
						notify-send "Éxito - $i" "$i sincronizadas correctamente"
					else
						notify-send "Error - $i" "Fallo en sincronización de $i"
					fi
				done
				;;
		esac
		;;
	WAN)
		for i in "${server_routes[@]}"
		do
			rsync -vrP -e "ssh -i ~/.ssh/id_rsa_dqnid" --delete-after /home/danih/Documents/$i dqnid@dqnid.com:/home/dqnid/Documents
			if test $? -eq 0; then
				notify-send "Éxito - $i" "$i sincronizadas correctamente"
			else
				notify-send "Error - $i" "Fallo en sincronización de $i"
			fi
		done
		;;
esac
