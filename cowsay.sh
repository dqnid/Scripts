#!/bin/bash

conversation=()
# conversation=("Hola dinosaurio" "Hola señora vaca" "Estás muuuuuu guapo" "Tu si que estás guapa" "No, tu" "He dicho que tu" "Eso he dicho yo me cago en mis muertos te voy a comer!" "Te falta valor chaval tu a mi no me conoces!" "ñam!" "~muere~")

for key in "${!conversation[@]}"
do
  if test "$(($key % 2))" == "1"; then
    python ~/Packages/dinosay/dinosay/dinosay.py -d para "${conversation[$key]}"
    sleep 2
  else
    cowsay "${conversation[$key]}"
    sleep 2
  fi
  clear
done
