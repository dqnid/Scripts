#!/bin/bash

#Cierro dmenu
pgrep -x dmenu && exit
#Guardo los discos a listar ($1) junto a sus tamaños ($4)
montable=$(lsblk -lp | grep "part /." | grep -v "nvme" | awk '{print $1, "(" $4 ")"}')
#Si montable vacío: salgo
[[ "$montable" = "" ]] && exit 1
eleccion=$(rofi -no-config -no-lazy-grab -sep "\n" -dmenu -i -p '¿Disco a desmontar?' -theme ~/Scripts/Temas/discos.rasi <<< "$montable" | awk '{print($1)}')
[[ "$eleccion" = "" ]] && exit 1

udisksctl unmount -b "$eleccion"
