#!/bin/bash
sudo dislocker -V $1 -u -- /media/bitlocker
sudo mount -o loop /media/bitlocker/dislocker-file /media/contenido
