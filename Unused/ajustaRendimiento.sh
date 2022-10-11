#!/bin/bash

modo="$(rofi -no-config -no-lazy-grab -sep "|" -demnu -i -p '¿Modo?' -width 12 -line-padding 3 -lines 3 -theme ~/Guiones/Temas/monitor.rasi <<< "battery|performance|balanced")"
echo $modo > /sys/class/drm/card0/device/power_dpm_state
