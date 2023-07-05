#!/bin/bash
if [ $# -ne 2 ]
then
	echo "./ejecutable auxiliar/ fichero.tex"
	exit 1
fi
dir=$(pwd)

pdflatex "$dir/$2"
bibtex "$dir/${2%.*}"
pdflatex "$dir/$2"
pdflatex "$dir/$2"
mv "$dir/${2%.*}.aux" "$dir/$1/"
mv "$dir/${2%.*}.log" "$dir/$1/"
mv "$dir/${2%.*}.out" "$dir/$1/"
mv "$dir/${2%.*}.toc" "$dir/$1/"
mv "$dir/${2%.*}.lot" "$dir/$1/"
mv "$dir/${2%.*}.lof" "$dir/$1/"
echo "$dir/${2%.*}"

#pdflatex --output-directory="$dir/$1" "$dir/$2"
#bibtex "$dir/$1/${2%.*}"
#pdflatex --output-directory="$dir/$1" "$dir/$2"
#pdflatex --output-directory="$dir/$1" "$dir/$2"
#pdf=$(echo $2 | awk -F'.tex' '{print $1}')
#mv "$dir/$1/$pdf.pdf" "$dir/"
