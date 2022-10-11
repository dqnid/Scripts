#!/bin/bash
sudo mount -t cifs -o rw,username=danih,domain=ad009,uid=1000,file_mode=0777,dir_mode=0777,gid=1001 //192.168.0.107/Compartido /mnt/Compartido
