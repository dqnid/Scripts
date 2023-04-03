#!/bin/bash

pgrep -x dmenu && exit

class=$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'Type of disc?' -theme ~/Scripts/rofi/drives.rasi <<< "NORMAL|ENCRYPTED|SERVER")
[[ "$class" = "" ]] && exit 1

case "$class" in
	ENCRYPTED)
		sudo -A umount /mnt/Encrypted
		sudo -A cryptsetup luksClose dqnid
		if test $? -eq 0;then
			notify-send "Unmounted" "Disc unmounted"
		fi
		;;
	NORMAL)
		montable=$(lsblk -lp | grep "part /." | grep -v "nvme" | awk '{print $1, "(" $4 ")"}')
		if test "$montable" == ""; then
			notify-send "Error" "No discs found to umount"
			exit 1
		fi
		eleccion=$(rofi -no-config -no-lazy-grab -sep "\n" -dmenu -i -p 'Disc to unmount?' -theme ~/Scripts/rofi/drives.rasi <<< "$montable" | awk '{print($1)}')
		[[ "$eleccion" = "" ]] && exit 1
		udisksctl unmount -b "$eleccion"
		;;
	SERVER)
		umount /mnt/Server
		;;
esac
