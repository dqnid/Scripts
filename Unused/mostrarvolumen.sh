#!/bin/bash
valor="$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master))"
notify-send "Volumen:" "$valor"
