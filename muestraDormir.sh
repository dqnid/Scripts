#!/bin/bash

if [ -f "/tmp/sleepStopped" ]; then
	echo "Suspensión %{F#da2c38}pausada"
else
	echo "Suspensión %{F#4c956c}activa"
fi
