#!/bin/bash
sudo sshfs -o allow_other,default_permissions -o ssh_command="ssh -i ~/.ssh/id_local" dqnid@192.168.0.109:/home/dqnid /mnt/LocalServer
