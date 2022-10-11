#!/bin/sh

getDir(){
	rofi -dmenu\
	-i\
	-no-fixed-num-lines\
	-p "Usuario@servidor: "\
	-theme ~/Scripts/Temas/confirm.rasi	
}

getPassw(){
	rofi -dmenu\
	-i\
	-no-fixed-num-lines\
	-p "Contraseña: "\
	-theme ~/Scripts/Temas/confirm.rasi	
}

dir=$(getDir)
passw=$(getPassw)

sshfs -p 2222 $dir /mnt/Server <<< $passw
