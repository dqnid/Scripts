#!/bin/bash

dir="~/Guiones/Temas/"
ubicaciones=("Anotaciones" "Proyectos" "Universidad")

getPasswd() {
    rofi -dmenu\
        -i\
        -no-fixed-num-lines\
        -p "¿Contraseña? : "\
        -theme $dir/confirm.rasi
}

passwd=$(getPasswd &)

for i in "${ubicaciones[@]}"
do
	val=$(nextcloudcmd --path /Documentos/$i --user danih --password $passwd /home/danih/Documentos/$i https://cloud.outzone.club)
	if test $? -eq 1; then
		notify-send "Error $i" "Fallo en sincronización de $i"
	else
		notify-send "Éxito - $i" "$i sincronizadas correctamente"
	fi
done
