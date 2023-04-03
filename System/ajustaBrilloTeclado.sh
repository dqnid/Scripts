#!/bin/bash
max=$(cat /sys/class/leds/asus::kbd_backlight/max_brightness)
actual=$(cat /sys/class/leds/asus::kbd_backlight/brightness)
if test $actual == $max; then
	echo 0 > /sys/class/leds/asus::kbd_backlight/brightness
else
	nueva=$(($actual + 1))
	echo $nueva > /sys/class/leds/asus::kbd_backlight/brightness
fi
