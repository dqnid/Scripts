#!/bin/bash

# Colores polybar

estilos="$(ls ~/.config/polybar/estilos/)"
formatos="Portable|Escritorio"

formato() {
	eleccion=$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '¿Formato?' -theme ~/Guiones/Temas/formatos.rasi <<< "$formatos")
	if test $eleccion == "Portable"; then
		sed -i -e 's/radius-top = 4.0/radius-top = 0.0/g' ~/.config/polybar/config.ini
		sed -i -e 's/radius-bottom = 4.0/radius-bottom = 0.0/g' ~/.config/polybar/config.ini
		sed -i -e 's/border-top-size = 4/border-top-size = 0/g' ~/.config/polybar/config.ini
		sed -i -e 's/border-bottom-size = 4/border-bottom-size = 0/g' ~/.config/polybar/config.ini
		sed -i -e 's/border-right-size = 4/border-right-size = 0/g' ~/.config/polybar/config.ini
		sed -i -e 's/border-left-size = 4/border-left-size = 0/g' ~/.config/polybar/config.ini

		sed -i -e 's/gaps inner 10/gaps inner 0/g' ~/.config/i3/config
		cp ~/.config/Wallpaper/wpSimple ~/.config/Wallpaper/wp
	elif test $eleccion == "Escritorio"; then
		sed -i -e 's/radius-top = 0.0/radius-top = 4.0/g' ~/.config/polybar/config.ini
		sed -i -e 's/radius-bottom = 0.0/radius-bottom = 4.0/g' ~/.config/polybar/config.ini
		sed -i -e 's/border-top-size = 0/border-top-size = 4/g' ~/.config/polybar/config.ini
		sed -i -e 's/border-bottom-size = 0/border-bottom-size = 0/g' ~/.config/polybar/config.ini
		sed -i -e 's/border-right-size = 0/border-right-size = 4/g' ~/.config/polybar/config.ini
		sed -i -e 's/border-left-size = 0/border-left-size = 4/g' ~/.config/polybar/config.ini

		sed -i -e 's/gaps inner 0/gaps inner 10/g' ~/.config/i3/config
		cp ~/.config/Wallpaper/wpComplejo ~/.config/Wallpaper/wp
	fi
	i3 restart
}

estilo(){
	eleccion=$(rofi -no-config -no-lazy-grab -sep "\n" -dmenu -i -p '¿Estilo?' -theme ~/Guiones/Temas/estilos.rasi <<< "$estilos")
	cp ~/.config/polybar/estilos/$eleccion/config.ini ~/.config/polybar/config.ini
	cp ~/.config/polybar/estilos/$eleccion/colors.ini ~/.config/polybar/colors.ini
	i3 restart
}

# Inicio
if test $1 -eq 1; then
	formato
elif test $1 -eq 0; then
	estilo
fi
