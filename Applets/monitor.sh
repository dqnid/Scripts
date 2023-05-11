#!/bin/bash
interno=eDP
externo=HDMI-A-0
externo2=DisplayPort-0
eleccion=""

#Todo mal pero tremendo palo cambiarlo:
# ejecutar un solo randr con variables
# modificar las variables en función de la entrada
# igual renta sacar las opciones del propio xrandr usando awk y grep
if xrandr | grep "$externo connected" && xrandr | grep "$externo2 connected"; then	
	eleccion="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'System' -width 12 -line-padding 3 -lines 3 -theme /home/danih/Scripts/rofi/monitor.rasi <<< "Una|Dos|Tres")"
	case "$eleccion" in
	Dos)
        xrandr --output "$interno" --off --output "$externo2" --above "$interno" --auto --output "$externo" --auto --rotate left --right-of "$externo2"
	;;
	Tres) 
        xrandr --output "$interno" --auto --output "$externo2" --above "$interno" --auto --output "$externo" --auto --right-of "$externo2"
	;;
	Una) 
		xrandr --output "$externo" --off --output "$externo2" --off --output "$interno" --auto
	;;
	esac
elif xrandr | grep "$externo connected"; then
	eleccion="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'System' -width 12 -line-padding 3 -lines 6 -theme /home/danih/Scripts/rofi/monitor.rasi <<< "Dual Side|Dual Top|Dual Side Vertical|Interna|Externa|Duplicar")"
	case "$eleccion" in
	"Dual Top")
		xrandr --output "$interno" --auto --mode 1920x1080 --output "$externo" --auto --above "$interno" --output "$externo2" --off
	;;
	"Dual Side")
		xrandr --output HDMI-A-0 --primary --mode 1920x1080 --rate 120 --pos 1920x0 --rotate normal --output eDP --mode 1920x1080 --rate 60 --pos 0x600 --rotate normal --output DisplayPort-0 --off --output DisplayPort-1 --off
	;;
	"Dual Side Vertical")
	xrandr --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate right --output eDP --primary --mode 1920x1080 --pos 1080x1762 --rotate normal --output DisplayPort-0 --off --output DisplayPort-1 --off	
	;;
	Duplicar) 
		xrandr --output "$interno" --auto --output "$externo" --same-as "$interno" --output "$externo2" --off
	;;
	Externa) 
		xrandr --output "$interno" --auto --output "$externo" --auto --above "$interno" --output "$externo2" --off
		xrandr --output "$externo" --mode 1920x1080 --rate 144 --output "$interno" --off --output "$externo2" --off
	;;
	Interna) 
		xrandr --output "$externo" --off --output "$externo2" --off --output "$interno" --auto
	;;
	esac
elif xrandr | grep "$externo2 connected"; then
	eleccion="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'System' -width 12 -line-padding 3 -lines 4 -theme /home/danih/Scripts/rofi/monitor.rasi <<< "Dual|Interna|Externa|Duplicar")"
	case "$eleccion" in
	Dual)
		xrandr --output "$interno" --auto --primary --output "$externo2" --above "$interno" --auto --output "$externo" --off
	;;
	Duplicar) 
		xrandr --output "$interno" --auto --output "$externo2" --same-as "$interno" --output "$externo" --off
	;;
	Externa) 
		xrandr --output "$interno" --auto --primary --output "$externo2" --above "$interno" --auto --output "$externo" --off
		xrandr --output "$externo2" --output "$interno" --off --output "$externo" --off
	;;
	Interna) 
	xrandr --output "$externo" --off --output "$externo2" --off --output "$interno" --auto
	;;
	esac	
else 
	xrandr --output "$externo" --off --output "$externo2" --off --output "$interno" --auto
fi
[[ "eleccion" = "" ]] && exit 1
i3 restart
#bspc wm -r
