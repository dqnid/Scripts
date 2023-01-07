#!/bin/bash
# Posible enmascarando targets de systemd, pero mejor con caffeine
# Ejecutar con caffeine

if [ -f "/tmp/sleepStopped" ]; then
	touch /tmp/sleep
	rm /tmp/sleepStopped
else
	touch /tmp/sleepStopped
	for (( ; ; )); do
		if [ -f "/tmp/sleep" ]; then
			rm /tmp/sleep
			exit 123
		fi
		sleep 5
	done
fi
