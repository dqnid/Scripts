#!/bin/bash

pgrep -x rofi && exit

get_passwd() {
     rofi -dmenu\
         -i\
         -no-fixed-num-lines\
         -p "Password : "\
         -theme ~/Scripts/rofi/confirm.rasi
}
get_dir(){
	rofi -dmenu\
	-i\
	-no-fixed-num-lines\
	-p "usr@dir: "\
	-theme ~/Scripts/rofi/getinfo.rasi	
}

class=$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'Type of drive: ' -theme ~/Scripts/rofi/drives.rasi <<< "NORMAL|ENCRYPTED|SERVER")
[[ "$class" = "" ]] && exit 1

if test $class == "SERVER"; then
	dir=$(get_dir)
	passw=$(get_passwd)
	sshfs -p 2222 $dir /mnt/Server <<< $passw
	if test $? -eq 0; then
		notify-send "Mounted" "Server mounted to /mnt/Server"
		exit 1
	else
		notify-send "Error mounting" "Couldn't mount the drive"
		exit 0
	fi
fi

montable=$(lsblk -lp | grep "part $" | grep -v "nvme"| grep -v "sda" | grep -v "sdb" | grep -v "sdc" | awk '{print $1, "(" $4 ")"}')
if test "$montable" == ""; then
	notify-send "Error" "No discs found to mount"
	exit 1
fi
eleccion=$(rofi -no-config -no-lazy-grab -sep "\n" -dmenu -i -p '¿Disco a montar?' -theme ~/Scripts/rofi/drives.rasi <<< "$montable" | awk '{print($1)}')
#eleccion=$(echo "$montable" | dmenu -i -p "¿Disco a montar?" -nb '#'$colorFondo -sf '#'$colorFondo -sb '#'$colorAzul -nf '#'$colorAzul -fn 'Envy Code R-12' | awk '{print($1)}')
[[ "$eleccion" = "" ]] && exit 1

case "$class" in
	ENCRYPTED)
		passwd=$(get_passwd &)

		echo $passwd | sudo -A cryptsetup luksOpen $eleccion dqnid
		sudo -A mount /dev/mapper/dqnid /mnt/Encrypted
		if test $? -eq 0;then
			notify-send "Mounted" "Disc mounted at /mnt/Encrypted"
		fi
		;;
	NORMAL)
		udisksctl mount -b "$eleccion"
		;;
esac
