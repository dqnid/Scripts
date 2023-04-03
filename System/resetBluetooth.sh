#!/bin/bash
#
#bluez
#bluetoothctl

sudo modprobe -r btusb
sudo modprobe btusb

sudo rmmod btusb
sudo modprobe btusb

connmanctl disable bluetooth
connmanctl enable bluetooth

bluetoothctl power off
bluetoothctl power on
