#!/bin/bash

x=$(cat /sys/class/backlight/amdgpu_bl0/brightness)
if test $1 -eq 1; then
	x=$(($x + $2))
	echo $x > /sys/class/backlight/amdgpu_bl0/brightness
elif test $1 -eq 0; then
	x=$(($x - $2))
	echo $x > /sys/class/backlight/amdgpu_bl0/brightness	
elif test $1 -eq 2; then
	echo 20 > /sys/class/backlight/amdgpu_bl0/brightness
fi
