#!/bin/bash
interno=eDP
externo=HDMI-A-0

#Todo mal pero tremendo palo cambiarlo:
# ejecutar un solo randr con variables
# modificar las variables en función de la entrada
# igual renta sacar las opciones del propio xrandr usando awk y grep
if xrandr | grep "$externo connected"; then
	eleccion="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'System' -width 12 -line-padding 3 -lines 6 -theme /home/danih/Scripts/rofi/monitor.rasi <<< "Dual Side|Dual Top|Dual Side Vertical|Dual Side Low|Interna|Externa|Duplicar")"
	case "$eleccion" in
	"Dual Top")
		xrandr --output "$interno" --auto --mode 1920x1080 --output "$externo" --auto --above "$interno" --output "$externo2" --off
	;;
	"Dual Side")
		xrandr --output HDMI-A-0 --primary --mode 1920x1080 --rate 60 --pos 1920x0 --rotate normal --output eDP --mode 1920x1080 --rate 60 --pos 0x600 --rotate normal
	;;
	"Dual Side Low")
		xrandr --output HDMI-A-0 --mode 1600x900 --pos 0x0 --rotate normal --output eDP --primary --mode 1920x1080 --rate 60 --pos 0x1080 --rotate normal
	;;
	"Dual Side Vertical")
	xrandr --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate right --output eDP --primary --mode 1920x1080 --pos 1080x1762 --rotate normal
	;;
	Duplicar) 
		xrandr --output "$interno" --auto --output "$externo" --same-as "$interno"
	;;
	Externa) 
		xrandr --output "$interno" --auto --output "$externo" --auto --above "$interno" --output "$externo2" --off
		xrandr --output "$externo" --mode 1920x1080 --rate 144 --output "$interno" --off
	;;
	Interna) 
		xrandr --output "$externo" --off --output "$interno" --auto
	;;
	esac
else 
	xrandr --output "$externo" --off --output "$externo2" --off --output "$interno" --auto
fi
[[ "eleccion" = "" ]] && exit 1
i3 restart
#bspc wm -r
