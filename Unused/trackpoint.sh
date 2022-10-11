#!/bin/bash
id=$(xinput list | grep TrackPoint | awk '{print $6}' | grep -o '[0-9]\+') && prop=$(xinput list-props $id | grep "libinput Accel Speed (" | awk '{print $4}' | grep -o '[0-9]\+') && xinput set-prop $id $prop 0.9 && unset id && unset prop
