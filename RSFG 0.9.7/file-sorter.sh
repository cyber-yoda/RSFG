#!/usr/bin/env bash
#breaks down and sorts Clean.txt
#

b=$(cat TempFiles/Value.txt) #reads user input from Value.txt

if [ $b = 'S' ] || [ $b = 's' ]; then # silent mode
	more TempFiles/Clean.txt | tr ' ' '\n' | tr -s '\n' | sort > TempFiles/Sorted.txt 	
									# opens Clean.txt, replaces spaces with newlines,
									# removes extra newlines, sorts the file
									# records the result to Sorted.txt
elif [ $b = 'V' ] || [ $b = 'v' ]; then
	echo
	echo 'Sorting Clean.txt'
	echo
	more TempFiles/Clean.txt | tr ' ' '\n' | tr -s '\n' | sort  > TempFiles/Sorted.txt   

	echo
	echo 'Script Complete'
	echo

else

	echo $b ": Expected S/s or V/v"

fi
