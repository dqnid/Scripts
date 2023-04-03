#!/bin/bash

#limpiar cache de paquetes
paccache -r

# Eliminar huérfanos
paquetes=$(sudo pacman -Qtdq)

sudo pacman -Rns $paquetes
