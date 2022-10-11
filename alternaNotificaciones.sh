#!/bin/bash
pausa=$(dunstctl is-paused)
if [ $pausa == 'false' ]
then
	dunstctl close-all
	dunstctl set-paused true
else
	dunstctl close-all
	dunstctl set-paused false
	notify-send "Notificaciones activadas"
fi
