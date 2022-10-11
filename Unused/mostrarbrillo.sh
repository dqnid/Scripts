#!/bin/bash
valor="$(light -G)%"
notify-send "Brillo:" "$valor"
