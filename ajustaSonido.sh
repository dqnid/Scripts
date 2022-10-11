#!/bin/bash

volumen="100|90|80|70|60|50|40|30|20|10|0"
elegirPorcentaje (){	
	eleccion=$(rofi -no-config -no-lazy-grab -hover-select -me-select-entry '' -me-accept-entry MousePrimary -sep "|" -dmenu -i -p ¿Volumen? -theme ~/Scripts/Temas/pulsemenu.rasi <<< "$volumen")
	echo "$eleccion"
}

if [ $1 -eq 1 ]; then
	eleccion="$(elegirPorcentaje)"
	pamixer --set-volume $eleccion
else 
	opciones="Salida|Entrada|V.Salida|V.Entrada|Pavucontrol"
	eleccion=$(rofi -no-config -no-lazy-grab -hover-select -me-select-entry '' -me-accept-entry MousePrimary -sep "|" -dmenu -i -p ¿Acción? -theme ~/Scripts/Temas/pulsemenu.rasi <<< "$opciones")
	
	case $eleccion in
		Salida)
			dispositivo=$(pamixer --list-sinks | grep -v "Sinks:" | awk '{print $1}')
			eleccion=$(rofi -no-config -no-lazy-grab -hover-select -me-select-entry '' -me-accept-entry MousePrimary -sep "\n" -dmenu -i -p ¿Dispositivo? -theme ~/Scripts/Temas/pulsemenu.rasi <<< "$dispositivo")
			# No funciona, no encuentro herramienta que lo haga sencillo. pacmd parece que tocará.
			pacmd list-sinks | grep "alsa.name"
			pacmd set-default-sink $eleccion
			;;
		Entrada)
			;;
		V.Salida)
			eleccion="$(elegirPorcentaje)"
			pamixer --set-volume $eleccion
			;;
		V.Entrada)
			eleccion="$(elegirPorcentaje)"
			# Chapuza, solo cambia el volumen del micrófono del portátil, debería cambiar el que esté predeterminado.
			dispositivo=$(pamixer --list-sources | grep "Digital Microphone" | awk '{print $1}')	
			pamixer --source $dispositivo --set-volume $eleccion
			;;
		Pavucontrol)
			pavucontrol
			;;
		*)
			exit 1
			;;
	esac
	sinks=$(pamixer --list-sinks)
	sources=$(pamixer --list-sources)
fi
#awk '/Raptors/,/Celtics/ { print $1 }'
