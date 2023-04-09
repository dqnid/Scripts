#!/bin/bash

# To-do: Add Eww widgets or other interface

theme="~/Scripts/rofi/"

server_routes=("Anotaciones" "Universidad/Segundo[[:space:]]Cuatrimestre/" "Universidad/TFG/")
images=("Images/Carteles[[:space:]]OZ/" "Images/Proyectos/" "Images/Croquis[[:space:]]Heras[[:space:]]C.B")
docs=("Documents/Anotaciones/" "Documents/Proyectos/" "Documents/Universidad/")
music="Music/"
videos=("Videos/Proyectos/")

ask_operation(){
	rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'Action' -width 12 -line-padding 3 -lines 2 -theme /home/danih/Scripts/rofi/sinc.rasi <<< "PUSH|PULL"
}

ask_net(){
	rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'Network' -width 12 -line-padding 3 -lines 2 -theme /home/danih/Scripts/rofi/sinc.rasi <<< "LAN|WAN"
}

ask_what_to_sync(){
	rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'Files To Sync' -width 12 -line-padding 3 -lines 2 -theme /home/danih/Scripts/rofi/sinc.rasi <<< "Full|Documents|Images|Videos|Music"
}

net=$(ask_net &)
operation=$(ask_operation &)
files_to_sync=$(ask_what_to_sync &)
if test "$net" == "WAN"; then
	for i in "${server_routes[@]}"
	do
		rsync -vrP -e "ssh -i ~/.ssh/id_rsa_dqnid" --delete-after /home/danih/Documents/$i dqnid@dqnid.com:/home/dqnid/Documents
		if test $? -eq 0; then
			notify-send "Éxito - $i" "$i sincronizadas correctamente"
		else
			notify-send "Error - $i" "Fallo en sincronización de $i"
		fi
	done
	exit 0
else
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
	case "$files_to_sync" in
		Documents)
			for dir in "${docs[@]}"
			do
				rsync -vrP -e "ssh -i ~/.ssh/id_local" --delete-after $origin/$dir $dest/$dir
			done
			;;
		Images)
			for dir in "${images[@]}"
			do
				rsync -vrP -e "ssh -i ~/.ssh/id_local" --delete-after $origin/$dir $dest/$dir
			done
			;;
		Videos)
			for dir in "${videos[@]}"
			do
				rsync -vrP -e "ssh -i ~/.ssh/id_local" --delete-after $origin/$dir $dest/$dir
			done
			;;
		Music)
			rsync -vrP -e "ssh -i ~/.ssh/id_local" --delete-after $origin/Music/ $dest/Music/
			;;
	esac
fi
