#!/bin/bash

#Cierro dmenu
pgrep -x dmenu && exit
#Guardo los discos a listar ($1) junto a sus tamaños ($4)
montable=$(lsblk -lp | grep "part $" | grep -v "sda" | awk '{print $1, "(" $4 ")"}')
#Si montable vacío: salgo
[[ "$montable" = "" ]] && exit 1
eleccion=$(echo "$montable" | dmenu -i -p "¿Disco a montar?" -fn 'Envy Code R-16' | awk '{print($1)}')
#eleccion=$(echo "$montable" | dmenu -i -p "¿Disco a montar?" -nb '#'$colorFondo -sf '#'$colorFondo -sb '#'$colorAzul -nf '#'$colorAzul -fn 'Envy Code R-12' | awk '{print($1)}')
[[ "$eleccion" = "" ]] && exit 1

udiskie-mount "$eleccion"
