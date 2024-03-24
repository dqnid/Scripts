#!/bin/bash

masterId=$(xinput list | grep "Virtual core keyboard" | awk '{print $5}')
internalId=$(xinput list | grep "AT Translated.*keyboard" | awk '{print $7}')
floatingId=$(xinput list | grep "AT Translated.*keyboard.*floating" | awk '{print $7}')
masterId=${masterId:3}
internalId=${internalId:3}
floatingId=${floatingId:3}

if [[ $1 == "toggle" ]]; then
  if [[ -n $floatingId ]]; then
    xinput reattach $floatingId $masterId
  else
   xinput float $internalId 
  fi
elif [[ $1 == "on" ]]; then
  xinput reattach $floatingId $masterId 
else
  if [[ -n $floatingId ]]; then
    echo " off"
  else
    echo " on"
  fi
fi
