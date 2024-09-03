#!/bin/bash

if [[ $1 == "off" ]]; then
  xmodmap -e "keycode  49 = dead_grave dead_tilde dead_grave dead_tilde grave asciitilde grave"
  xmodmap -e "keycode   9 = Escape NoSymbol Escape"
else
  xmodmap -e "keycode 49 = Escape NoSymbol Escape"
  xmodmap -e "keycode 9 = dead_grave dead_tilde dead_grave dead_tilde grave asciitilde grave"
  xmodmap -e "keycode 66 = Escape NoSymbol Escape"
  xmodmap -e "clear lock"
fi
