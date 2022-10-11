#!/bin/bash
opcion="Universidad|Música|voidrice"
opcion2="Completo|Vídeos|Proyectos|Asignaturas"
opcion3=""
usb="C432-773E"
docs="Documentos"
asignaturas="Primer[[:space:]]Cuatrimestre"
proyectos="Proyectos"

if test $# -ne 1; then
	exit 1
fi
opcionUsb=$(lsblk -lp | grep "part /." | grep -v "sda" | awk '{print $7}')
usb=$(rofi -no-config -no-lazy-grab -dmenu -i -p '¿Disco?' -theme ~/Guiones/Temas/sinc.rasi <<< "$opcionUsb")
[[ "$usb" = "" ]] && exit 1
eleccion=$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '¿Directorio?' -theme ~/Guiones/Temas/sinc.rasi <<< "$opcion")
case "$eleccion" in
	    Universidad)
			eleccion2=$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '¿Amplitud?' -theme ~/Guiones/Temas/sinc.rasi <<< "$opcion2")
			case "$eleccion2" in
				Completo)
					if test $1 -eq 1; then
	         			rsync -vr $usb/Documentos/Universidad/ $docs/Universidad/ -auto
					else 
	         			rsync -vr $docs/Universidad/ $usb/Documentos/Universidad/ -auto
					fi
					;;		
				Vídeos)
					if test $1 -eq 1; then
	         			rsync -vr $usb/Vídeos/Lecciones/ ~/Vídeos/Lecciones/ -auto
					else 
	         			rsync -vr ~/Vídeos/Lecciones/ $usb/Vídeos/Lecciones/ -auto
					fi
					;;
				Proyectos)
					if test $1 -eq 1; then
	         			rsync -vr $usb/Documentos/Universidad/$proyectos $docs/Universidad/$proyectos/ -auto
					else 
	         			rsync -vr $docs/Universidad/$proyectos/ $usb/Documentos/Universidad/$proyectos -auto
					fi
					;;
				Asignaturas)
					if test $1 -eq 1; then
	         			rsync -vr $usb/Documentos/Universidad/$asignaturas/ $docs/Universidad/$asignaturas/ -auto 
					else
						rsync -vr $docs/Universidad/$asignaturas/ $usb/Documentos/Universidad/$asignaturas/ -auto 
					fi
					;;
			esac
			if test $1 -eq 1; then
            	rsync -vr $usb/Documentos/Anotaciones/ $docs/Anotaciones/ -auto
            	rsync -vr $usb/Documentos/Universidad/Horarios/ $docs/Universidad/Horarios/ -auto
			else 
            	rsync -vr $docs/Anotaciones/ $usb/Documentos/Anotaciones/ -auto
            	rsync -vr $docs/Universidad/Horarios/ $usb/Documentos/Universidad/Horarios/ -auto
			fi
	    ;;
		Música)
			if test $1 -eq 1; then
	        	rsync -vr $usb/Música/ ~/Música/ -auto
			else 
	        	rsync -vr ~/Música/ $usb/Música/ -auto
			fi
		;;
        voidrice)  #Mejor hacer un bucle con un array de los ficheros y carpetas
            rsync -vr /etc/X11/xorg.conf.d/00-keyboard.conf /run/media/danih/$usb/Documentos/voidrice_Arch/etc/X11/xorg.conf.d/
            rsync -vr /etc/X11/xorg.conf.d/50-synaptics.conf /run/media/danih/$usb/Documentos/voidrice_Arch/etc/X11/xorg.conf.d/
            rsync -vr ~/.bashrc $usb/Documentos/voidrice_Arch/
            rsync -vr ~/.xinitrc $usb/Documentos/voidrice_Arch/
            rsync -vr ~/Paquetes/st/ $usb/Documentos/voidrice_Arch/Paquetes/st/
            rsync -vr ~/.config/i3/ $usb/Documentos/voidrice_Arch/config/i3/
            rsync -vr ~/.config/polybar/ $usb/Documentos/voidrice_Arch/config/polybar/
            rsync -vr ~/.config/mpd/ $usb/Documentos/voidrice_Arch/config/mpd/
            rsync -vr ~/.config/ncmpcpp/ $usb/Documentos/voidrice_Arch/config/ncmpcpp/
            rsync -vr ~/.config/dunst/ $usb/Documentos/voidrice_Arch/config/dunst/
            rsync -vr ~/.config/nvim/ $usb/Documentos/voidrice_Arch/config/nvim/
            rsync -vr ~/.config/picom.conf $usb/Documentos/voidrice_Arch/config/
            rsync -vr ~/.config/ranger/ $usb/Documentos/voidrice_Arch/config/ranger/ 
            rsync -vr ~/Guiones/ $usb/Documentos/voidrice_Arch/Guiones/
            rsync -vr ~/.config/sxhkd/ $usb/Documentos/voidrice_Arch/config/sxhkd/ 
    	;;
esac
read -p "Pulsa para salir"
