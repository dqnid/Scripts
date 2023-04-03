#!/bin/bash
state=$(cat ~/Scripts/.focusState)
if test $state -eq 0; then
	polybar-msg cmd hide
	i3-msg gaps inner all set 0
	echo 1 > ~/Scripts/.focusState
else
	polybar-msg cmd show
	i3-msg gaps inner all set 30
	echo 0 > ~/Scripts/.focusState
fi
