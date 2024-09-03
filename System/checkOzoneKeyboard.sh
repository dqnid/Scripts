#!/bin/bash

ozoneId=$(xinput list | grep "Ozone Tactical")

if [[ -n $ozoneId ]]; then
xmodmap -e "keycode 49 = Escape NoSymbol Escape"
xmodmap -e "keycode 9 = dead_grave dead_tilde dead_grave dead_tilde grave asciitilde grave"
xmodmap -e "keycode 66 = Escape NoSymbol Escape"
xmodmap -e "clear lock"
else
  xmodmap -e "keycode  49 = dead_grave dead_tilde dead_grave dead_tilde grave asciitilde grave"
  xmodmap -e "keycode   9 = Escape NoSymbol Escape"
fi
