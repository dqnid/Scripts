#!/bin/bash
groff -ms -D UTF-8 ~/Documents/Anotaciones/Ficheros\ Fuente/Documentación_Linux.ms -T pdf > ~/Documents/Anotaciones/Documentación_Linux.pdf
groff -ms -D UTF-8 ~/Documents/Anotaciones/Ficheros\ Fuente/Atajos.ms -T pdf > ~/Documents/Anotaciones/Atajos.pdf
if test $1 -eq 1; then
	mupdf-x11 ~/Documents/Anotaciones/Documentación_Linux.pdf
else
	mupdf-x11 ~/Documents/Anotaciones/Atajos.pdf
fi
