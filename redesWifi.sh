#!/bin/bash

#Versión megabásica que no diferencia entre redes con passphrase y password
#A parte parece que puede fallar el scan

contra() {
     rofi -dmenu\
         -i\
         -no-fixed-num-lines\
         -p "¿Contraseña? : "\
         -theme ~/Scripts/Temas/confirm.rasi
}

antena=$(iwctl device list | grep on | awk '{print $2}')
iwctl station $antena scan #posible error
redes=$(iwctl station $antena get-networks | grep '*' | awk '{print $1}')
if test $? == 1; then
	return 1;
fi
eleccion=$(rofi -no-config -no-lazy-grab -sep "\n" -dmenu -i -p '¿Red a conectar?' -theme ~/Scripts/Temas/discos.rasi <<< $redes)
pass=$(contra &)
iwctl --passphrase $pass station $antena connect $eleccion
