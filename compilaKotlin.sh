#!/bin/bash
if test $# -eq 1; then
	dir=$(pwd)
	jar=$(echo $1 | awk -F'.kt' '{print $1}')
	kotlinc "$dir/$1" -include-runtime -d "$dir/$jar.jar"
elif test $# -eq 2; then
	dir=$(pwd)
	jar=$(echo $2 | awk -F'.kt' '{print $1}')
	if test $1 -eq 1; then
		java -jar "$dir/$jar.jar"
	fi
else
	echo "Modo de uso:"
	echo -e " $ \u001b[32mck nombre.kt \u001b[0m"
	echo -e " $ \u001b[33mck nombre.kt 1\u001b[0m"
	exit 1
fi
