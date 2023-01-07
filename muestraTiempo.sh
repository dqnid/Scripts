#!/bin/bash
#tiempo="$(~/Packages/ansiweather/ansiweather -l "Béjar,ES" -u metric -s true -f 1 -d true | awk '{print $7$8 $9}' | sed $'s/\e\\[[0-9;:]*[a-zA-Z]//g')"
#tiempo=$(curl -s wttr.in/Béjar?format="%l:+%c+%t+%p\n")
#echo "%{F#66ffffff}Béjar: %{F#ffffff}$tiempo"
tiempo=$(curl -s wttr.in/Béjar?format="%l:+%C+%t+%p\n")
echo "$tiempo"
