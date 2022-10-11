#!/bin/sh
SERVICE="glava"
if pgrep -x "$SERVICE" >/dev/null
then
	killall glava
else
	if xrandr | grep "HDMI-1 connected"; then
		glava --desktop --force-mod=circle --entry=hdmiconfig.glsl &
		glava --desktop --entry=dualconfig.glsl &
	else	
		glava --desktop &
	fi
fi
