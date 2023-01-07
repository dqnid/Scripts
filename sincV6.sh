#!/bin/bash

dir="~/Scripts/Temas/"
ubicaciones=("Anotaciones" "Proyectos" "Universidad")
ubicaciones_avanzado=("Documents" "Music" "Scripts" "Images" "Videos")


eleccion="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'Destinos' -width 12 -line-padding 3 -lines 2 -theme /home/danih/Scripts/Temas/sinc.rasi <<< "LAN|WAN")"

case "$eleccion" in
	LAN)
		for i in "${ubicaciones_avanzado[@]}"
		do
			rsync -vrP -e "ssh -i ~/.ssh/id_rsa_dqnid" --delete-after /home/danih/$i dqnid@192.168.0.114:/home/dqnid/
			if test $? -eq 0; then
				notify-send "Éxito - $i" "$i sincronizadas correctamente en el servidor local"
			else
				notify-send "Error $i" "Fallo en sincronización de $i"
			fi
		done
		;;
	WAN)
		for i in "${ubicaciones[@]}"
		do
			rsync -vrP -e "ssh -i ~/.ssh/id_rsa_dqnid" --delete-after /home/danih/Documents/$i dqnid@dqnid.com:/home/dqnid/Documents
			if test $? -eq 0; then
				notify-send "Éxito - $i" "$i sincronizadas correctamente"
			else
				notify-send "Error $i" "Fallo en sincronización de $i"
			fi
		done
		;;
esac
