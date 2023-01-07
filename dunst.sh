#!/bin/sh
if [ $(dunstctl is-paused) == 'false' ]
then
	echo "%{F#FFFFFF}"
else
	echo "%{F#ffbe0b} Pausadas"
fi
