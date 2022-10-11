#!/bin/bash
id=$(xinput list | grep Touchpad | awk '{print $6}' | grep -o '[0-9]\+')
prop=$(xinput list-props $id | grep "Device Enabled (" | awk '{print $3}' | grep -o '[0-9]\+')
val=$(xinput list-props $id | grep "Device Enabled (" | awk '{print $4}' | grep -o '[0-9]\+')

if [ $val = 1 ]; then
	val=0
else
	val=1
fi
xinput set-prop $id $prop $val
unset id
unset prop
unset val
