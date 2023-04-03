#!/bin/bash

home="/home/danih"
modelos="$home/Documents/Modelos"
biblio="$modelos/biblio.bib"
dir=$(pwd)

preguntaNombre() {
     rofi -dmenu\
         -i\
         -no-fixed-num-lines\
         -p "Nombre : "\
         -theme ~/Scripts/Temas/confirm_visible.rasi
}

plantilla="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p 'Plantilla' -width 12 -line-padding 3 -lines 3 -theme ~/Scripts/Temas/latex.rasi <<< "Base|Universidad|Simple")"
if [[ $plantilla == "" ]]; then
	exit 1
fi

images=false
case "$plantilla" in
	"Base")
		plantilla="base.tex"
		;;
	"Universidad")
		plantilla="usal.tex"
		images=true
		;;
	"Simple")
		plantilla="simple.tex"
		;;
	*)
		plantilla="base.tex"
		;;
esac

base=$modelos/$plantilla

nombre=$(preguntaNombre &)
if [[ $nombre == "" ]]; then
	exit 1
fi

final=$(echo $nombre | awk -F'.tex' '{print $1}')

cp $biblio "$dir"
if test -f "$dir/${final}.tex"; then
	cp $base "$dir/${final}$(date +"%m%d%Y").tex"
else
	cp $base "$dir/$final.tex"
fi

if [[ $images == true ]]; then
	cp -r "$modelos/images $dir"
fi
exit 0
