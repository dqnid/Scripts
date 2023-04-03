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

antena="wlan0"

# Refresco primero
iwctl station $antena get-networks
redes=$(iwctl station $antena get-networks | grep '*' | awk '{print $2}')
[[ $? == 1 ]] && exit 1

eleccion=$(rofi -no-config -no-lazy-grab -sep "\n" -dmenu -i -p '¿Red a conectar?' -theme ~/Scripts/Temas/discos.rasi <<< $redes)
[[ "$eleccion" == "" ]] && exit 1

pass=$(contra &)
[[ $pass == "" ]] && exit 1
iwctl --passphrase $pass station $antena connect $eleccion
[[ $? == 1 ]] && exit 1
