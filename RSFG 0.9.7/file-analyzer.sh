#!/usr/bin/bash

#
# Project: file-analyzer.sh
# Author: Cyber-Yoda
# Description: Forked from jfish781 with goal of rewriting to be more... 'optimal' in terms of performance (not ASM optimal but you get it...)
#

# Replaced entire banner to use: printf "", read -p, response
printf "\n"
read -p  " Analyze Otput? Y/n >  " response
printf

# Refactor to use Registry Expression
if [[ $response =~ ^([Yy]|[Yy][Ee][Ss])$ || [ -z $response ]]; then
	a=$(grep -v '^[[:blank:]]*$'  TempFiles/Sorted.txt) # removes all blank lines from the input file
	echo -e "$a \n" > TempFiles/SortedNB.txt #copies the contents of a to SortedNB.txt 
	echo > TempFiles/Analysis.txt # Creates a blank file called Analysis.txt in the TempFiles directory

	while read p; do # for each line in Sorted.txt, preform these actions...
		grep $(head -n1 TempFiles/SortedNB.txt) TempFiles/Sorted.txt > TempFiles/Search.txt # grabs the first word from a, sends the result to Search.txt
		printf '%-4s %s | ' "$(wc -w TempFiles/Search.txt | tr -d 'TempFiles/Search.txt')" >> TempFiles/Analysis.txt # prints the word count of Search.txt, but does not display the file path, and formats the output 
		echo  "$(head -n1 TempFiles/SortedNB.txt)" >> TempFiles/Analysis.txt # prints the first line of Sorted.NB.txt, with no traling newline.
		sed -i '1d' TempFiles/SortedNB.txt # deletes the first line of the file
	done  < TempFiles/Sorted.txt

	sed -i '$ d' TempFiles/Analysis.txt # deletes the last line of the file

	echo -e "How do you want to sort the output?\n\n1: Alphabetical\n2: Biggest First\n3: Smallest First\n4: Random "
 	read w
	echo
	if [ $w = '1' ]; then

	cat TempFiles/Analysis.txt | uniq > TempFiles/Output.txt # because the input file is already sorted, uses uniq to remove dupe lines, and puts the result in TempFiles/Output.txt
	more TempFiles/Output.txt

	elif [ $w = '2' ]; then

	sort -rn TempFiles/Analysis.txt | uniq > TempFiles/Output.txt # preforms a reverse numeric sort, removes dupe lines
	more TempFiles/Output.txt

	elif [ $w = '3' ]; then

        sort -n TempFiles/Analysis.txt | uniq > TempFiles/Output.txt # preforms a regular numeric sort, removes dupe lines
        more TempFiles/Output.txt

	elif [ $w = '4' ]; then

	sort -R TempFiles/Analysis.txt | uniq > TempFiles/Output.txt # preforms a random sort, removes dupe lines
        more TempFiles/Output.txt

	else

	echo $w ": Expected 1 2 3 or 4"

	fi
elif [ $z = 'N' ] || [ $z = 'n' ]; then

	echo 'Goodbye!'
	echo

else

	echo $z ": Expected Y/y or N/n"
fi
