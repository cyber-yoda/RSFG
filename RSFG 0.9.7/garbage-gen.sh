#!/usr/bin/env bash
#generates a file full of random junk
#
# set envrioment var from Value.txt

a=$(cat TempFiles/Value.txt) # reads user input

if [ $a = 'S' ] || [ $a = 's' ]; then # silent mode
	touch TempFiles/Junk.txt # creates Junk.txt if it does not exist.
	for a in {1..9}
	do
	#echo >> TempFiles/Junk.txt
	./RandomGen >> TempFiles/Junk.txt # runs the random gen command 9 times and appends the results to Junk.txt
	echo >> TempFiles/Junk.txt
	done
elif [ $a = 'V' ] || [ $a = 'v' ]; then
	echo
	echo 'Creating an empty file: Junk.txt, or updating the time stamp if the file already exists...'
	echo
	touch TempFiles/Junk.txt
	echo
	echo 'Appending junk to file...'
	echo
	#starting for loop
	for a in {1..9}
	do
		#echo >> TempFiles/Junk.txt
		./RandomGen >> TempFiles/Junk.txt
		echo >> TempFiles/Junk.txt
	done
	echo
	echo 'Script complete'
	echo

else

	echo $a ": Expected S/s or V/v"

fi
	


