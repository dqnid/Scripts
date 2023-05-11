#!/bin/bash
state=$(cat ~/Scripts/.focusState)
if test $state -eq 0; then
	#polybar-msg cmd hide
	killall polybar
	bash ~/.config/polybar/dock/launch.sh
	i3-msg gaps inner all set 0
# sed -i "s/border_radius*/border_radius 0/g" ~/.config/i3/config
# sed -i "s/default_border*/default_border pixel 1/g" ~/.config/i3/config
	echo 1 > ~/Scripts/.focusState
else
	#polybar-msg cmd show
	i3-msg gaps inner all set 20
	killall polybar
	bash ~/.config/polybar/floating/launch.sh
# sed -i "s/border_radius*/border_radius 2/g" ~/.config/i3/config
# sed -i "s/default_border*/default_border pixel 4/g" ~/.config/i3/config
	echo 0 > ~/Scripts/.focusState
fi
