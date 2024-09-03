#!/bin/bash

if [[ $# != 1 ]]; then
  echo "push or pull"
  exit 1 
fi

localAccess=$(ping -c 1 192.168.1.144)
if [[ $? -eq 0 ]]; then
  url="dqnid@192.168.1.144"
else
  vpnAccess=$(ip addr show | grep tun0) # 1 for error, 0 for success
  if [[ $? -eq 0 ]]; then 
    url="dqnid@10.8.0.10" 
  else
    notify-send "Net error" "Connect to the VPN to access your data"
    exit 1
  fi
fi

if [[ $1 == "push" ]]; then
  origin="/home/danih/"
  dest="$url:/home/dqnid/"
else
  dest="/home/danih/"
  origin="$url:/home/dqnid/"
  today=$(date "+%H%M%S%d%m%y")
  tar -czf "/home/danih/Documents/Anotaciones/backups/anotaciones_$today.tar" "/home/danih/Documents/Anotaciones" # NOTE: wrong, full path instead of just Anotaciones
fi

rsync -vrP -e "ssh -i ~/.ssh/id_new_server_dqnid" $origin/Documents/Anotaciones/ $dest/Documents/Anotaciones/
