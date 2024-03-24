#!/bin/bash

# To-do: Add Eww widgets or other interface

theme="~/Scripts/rofi/"

images=("Images/")
docs=("Documents/")
music="Music/"
videos=("Videos/")

ask_operation(){
	rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'Action' -width 12 -line-padding 3 -lines 2 -theme /home/danih/Scripts/rofi/sinc.rasi <<< "PUSH|PULL"
}

ask_what_to_sync(){
	rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'Files To Sync' -width 12 -line-padding 3 -lines 2 -theme /home/danih/Scripts/rofi/sinc.rasi <<< "Full|Documents|Images|Videos|Music"
}

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



operation=$(ask_operation &)
files_to_sync=$(ask_what_to_sync &)
echo $url
case "$operation" in
    PUSH)
        origin="/home/danih/"
        dest="$url:/home/dqnid/"
        ;;
    PULL)
        dest="/home/danih/"
        origin="$url:/home/dqnid/"
        ;;
esac
case "$files_to_sync" in
    Full)
        for dir in "${docs[@]}"
        do
            rsync -vrP -e "ssh -i ~/.ssh/id_new_server_dqnid" --delete-after $origin/$dir $dest/$dir
        done
        for dir in "${images[@]}"
        do
            rsync -vrP -e "ssh -i ~/.ssh/id_new_server_dqnid" --delete-after $origin/$dir $dest/$dir
        done
        for dir in "${videos[@]}"
        do
            rsync -vrP -e "ssh -i ~/.ssh/id_new_server_dqnid" --delete-after $origin/$dir $dest/$dir
        done
        rsync -vrP -e "ssh -i ~/.ssh/id_new_server_dqnid" --delete-after $origin/Music/ $dest/Music/
      ;;
    Documents)
        for dir in "${docs[@]}"
        do
            rsync -vrP -e "ssh -i ~/.ssh/id_new_server_dqnid" --delete-after $origin/$dir $dest/$dir
        done
        ;;
    Images)
        for dir in "${images[@]}"
        do
            rsync -vrP -e "ssh -i ~/.ssh/id_new_server_dqnid" --delete-after $origin/$dir $dest/$dir
        done
        ;;
    Videos)
        for dir in "${videos[@]}"
        do
            rsync -vrP -e "ssh -i ~/.ssh/id_new_server_dqnid" --delete-after $origin/$dir $dest/$dir
        done
        ;;
    Music)
        rsync -vrP -e "ssh -i ~/.ssh/id_new_server_dqnid" --delete-after $origin/Music/ $dest/Music/
        ;;
esac

notify-send "Success" "Sync completed"
