#!/bin/bash

## Directorios generales en dir personal
directorios=("/home/danih/Música/" "/home/danih/Documentos/" "/home/danih/Vídeos/" "/home/danih/Imágenes/" "/home/danih/Guiones/")
## Directorios de configuración bajo .config
directoriosConfig=("mpd/" "ncmpcpp/" "nvim/" "ranger" "sxhkd" "polybar" "rofi" "kitty" "i3" "dunst" "mpv")
baseServidor="/home/danih/Configuración/"
baseLocal="/home/danih/.config/"
ip="192.168.0.111"

for i in "${directorios[@]}"
do
	rsync -avre 'ssh -p 2222' $i danih@$ip:$i
done

notify-send "¡Sistema base sincronizado!" "Copiando configuración..."

for i in "${directoriosConfig[@]}"
do
	rsync -avre 'ssh -p 2222' "$baseLocal$i" danih@$ip:"$baseServidor$i"
done

notify-send "¡Sincronización terminada!"
