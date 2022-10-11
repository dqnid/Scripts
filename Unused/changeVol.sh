#!/bin/bash

var=$(pactl list sinks short | grep "RUNNING" | awk '{print $1}')
if test $1 -eq 0; then
	pactl set-sink-mute $var toggle
else 
	sh -c "pactl set-sink-mute $var false ; pactl set-sink-volume $var $1%"
fi
