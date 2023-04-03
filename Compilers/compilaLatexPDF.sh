#!/bin/bash
if [ $# -ne 2 ]
then
	echo "./ejecutable auxiliar/ fichero.tex"
	exit 1
fi
dir=$(pwd)
#pdflatex --output-directory="$dir/$1" "$dir/$2"
xelatex --output-directory="$dir/$1" "$dir/$2"
pdf=$(echo $2 | awk -F'.tex' '{print $1}')
mv "$dir/$1/$pdf.pdf" "$dir/"
