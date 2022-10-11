#!/bin/bash
if test $# -eq 1; then
	yt-dlp -f 'ba' -x --audio-format mp3 $1  -o '%(title)s.%(ext)s'
else
	echo "$ youtubedw.sh 'enlace'"
fi
