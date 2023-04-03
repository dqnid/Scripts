#!/bin/bash
id=$(xinput list | grep Touchpad | awk '{print $6}' | grep -o '[0-9]\+')
tap=$(xinput list-props $id | grep "Tapping Enabled (" | awk '{print $4}' | grep -o '[0-9]\+')
speed=$(xinput list-props $id | grep "Accel Speed (" | awk '{print $4}' | grep -o '[0-9]\+')
scroll=$(xinput list-props $id | grep "Natural Scrolling Enabled (" | awk '{print $5}' | grep -o '[0-9]\+')

echo $id $tap $speed

xinput set-prop $id $tap 1
xinput set-prop $id $speed 0.4
xinput set-prop $id $scroll 1

unset id
unset prop
unset val
