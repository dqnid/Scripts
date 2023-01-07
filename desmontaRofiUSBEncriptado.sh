#!/bin/bash
sudo -A umount /mnt/Encrypted
sudo -A cryptsetup luksClose dqnid
