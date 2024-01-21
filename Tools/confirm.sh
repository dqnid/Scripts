#!/bin/bash
#
dir="~/.config/polybar/floating/scripts/rofi"

confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "\
		-theme $dir/confirm.rasi
}

msg() {
	rofi -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
}

  if test $# == 0; then
    echo "./confirm logout|suspend|poweroff|reboot "
  exit
fi

ans=$(confirm_exit &)
  if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
  case $1 in
    "poweroff")
      poweroff
      ;;
    "suspend")
      systemctl suspend
      ;;
    "reboot")
      reboot
      ;;
    "logout")
      i3-msg exit
      ;;
    default)
      echo "./confirm lock|suspend|poweroff|reboot "
        ;;
  esac
  elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
exit 0
  else
	msg
fi
