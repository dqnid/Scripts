#!/bin/bash
bin="bin"
if test $# -eq 1; then
	dir=$(pwd)
	jar=$(echo $1 | awk -F'.kt' '{print $1}')
	if test -d "$dir/$bin"; then
		kotlinc "$dir/$1" -include-runtime -d "$dir/$bin/$jar.jar"
	else
		kotlinc "$dir/$1" -include-runtime -d "$dir/$jar.jar"
	fi
elif test $# -ge 2; then
	dir=$(pwd)
	jar=$(echo $2 | awk -F'.kt' '{print $1}')
	if test $1 -eq 1; then
		if test -d "$dir/$bin"; then
			kotlinc "$dir/$2" -include-runtime -d "$dir/$bin/$jar.jar"
			java -jar "$dir/$bin/$jar.jar"
		else 
			kotlinc "$dir/$2" -include-runtime -d "$dir/$jar.jar"
			java -jar "$dir/$jar.jar"
		fi
	fi
else
	echo "Use:"
	echo -e " $ \u001b[32mck name.kt \u001b[0m"
	echo -e " $ \u001b[33mck name.kt 1\u001b[0m"
	echo -e "**note: if a bin folder exists, will output .jar there"
	exit 1
fi
