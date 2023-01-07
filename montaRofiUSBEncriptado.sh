#!/bin/bash

contra() {
     rofi -dmenu\
         -i\
         -no-fixed-num-lines\
         -p "¿Contraseña para dqnid? : "\
         -theme ~/Scripts/Temas/confirm.rasi
}

montable=$(lsblk -lp | grep "part $" | grep -v "nvme" | awk '{print $1, "(" $4 ")"}')
[[ "$montable" = "" ]] && exit 1
eleccion=$(rofi -no-config -no-lazy-grab -sep "\n" -dmenu -i -p '¿Disco a montar?' -theme ~/Scripts/Temas/discos.rasi <<< "$montable" | awk '{print($1)}')
[[ "$eleccion" = "" ]] && exit 1

passwd=$(contra &)

echo $passwd | sudo -A cryptsetup luksOpen $eleccion dqnid
sudo -A mount /dev/mapper/dqnid /mnt/Encrypted
