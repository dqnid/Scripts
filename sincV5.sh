#!/bin/bash

dir="~/Scripts/Temas/"
ubicaciones=("Anotaciones" "Proyectos" "Universidad")

for i in "${ubicaciones[@]}"
do
	rsync -vrP -e "ssh -i ~/.ssh/id_rsa_dqnid" --delete-after /home/danih/Documentos/$i dqnid@dqnid.com:/home/dqnid/Documentos
	if test $? -eq 0; then
		notify-send "Éxito - $i" "$i sincronizadas correctamente"
	else
		notify-send "Error $i" "Fallo en sincronización de $i"
	fi
done
