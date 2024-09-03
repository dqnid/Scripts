#!/bin/bash
sshfs -o default_permissions -o ssh_command="ssh -i ~/.ssh/id_new_server_dqnid" dqnid@192.168.1.147:/home/dqnid ~/Remote/LocalServer/
