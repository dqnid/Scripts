#!/bin/bash

icon="/home/danih/.config/i3/lock.png"
img="/home/danih/.cache/i3lock.png"

scrot $img
convert $img -scale 10% -scale 1000% $img
convert $img $icon -gravity center -composite $img

i3lock -u -i $img
