#!/bin/sh
if [ $(dunstctl is-paused) == 'false' ]
then
	echo "%{F#2193ff}"
else
	echo "%{F#ffbe0b} Pausadas"
fi
