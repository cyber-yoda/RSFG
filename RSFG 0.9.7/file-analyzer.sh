#!/usr/bin/env bash

#
# Project: file-analyzer.sh
# Author: Cyber-Yoda
# Description: Forked from jfish781 with goal of rewriting to be more... 'optimal' in terms of performance (not ASM optimal but you get it...)
#

# Replaced entire banner to use: printf "", read -p, response
printf "\n"
read -p " Analyze Output? Y/n >  " response
printf

# Refactor to use Registry Expression
if [[ $response =~ ^([Yy]|[Yy][Ee][Ss])$ || [ -z $response ]]; then
	grep -v '^[[:blank:]]*$'  TempFiles/Sorted.txt >> TempFiles/SortedNB.txt >> TempFiles/analyzer.txt # No longer a variable and creates new file 'analyzer.txt' for output rather using >>
	echo -e "$a \n" >> TempFiles/SortedNB.txt #copies the contents of $a to SortedNB.txt

	while read -r entry; do # for each line in analyzer.txt, preform the following...
 		search_term=$(head -n1 TempFiles/SortedNB.txt) # Start at the first line in TempFiles/analyzer.txt
		grep "$search_term" TempFiles/SortedNB.txt

    		word_count=$(awk '{ total += NF } END { print total }' TempFiles/Search.txt)
		printf '%-4s %s | ' "$word_count" >> TempFiles/Analysis.txt # prints the word count of Search.txt, but does not display the file path, and formats the output 
		printf "$search_term" >> TempFiles/Analysis.txt
  
		sed -i '1d' TempFiles/SortedNB.txt # deletes the first line of the file; similar functionality in vi (5d deletes 5 lines)
	done  < TempFiles/Sorted.txt

	sed -i '$ d' TempFiles/Analysis.txt # deletes the last line of the file

 	# Shortened Down Sort Options dramatically
	printf "How do you want to sort the output?\n\n"
 	printf "1: Alphabetical\n" sort_choice
  	printf "2: Biggest First\n" sort_choice
   	printf "3: Smallest First\n" sort_choice
    	printf "4: Random\n" sort_choice
 	read -r "[+] Select Sort Choice > " sort_choice
	print " "

 	case "$sort_choice" in
  		1)	# Solving issue with output not being Alphabetical, planning on switching over to awk instead
    			sort TempFiles/Analysis.txt | uniq TempFiles/Output.txt 
       			less TempFiles/Output.txt
       			;;
	  
    		2)	# Solving issue with output not being Alphabetical, planning on switching over to awk instead
      			sort -rn TempFiles/Analysis.txt | uniq >> TempFile/Output.txt
	 		less TempFiles/Output.txt
	 		;;
    
      		3)	# Solving issue with output not being Alphabetical, planning on switching over to awk instead
			sort -n TempFiles/Analysis.txt | uniq >> TempFiles/Output.txt
   			less TempFiles/Output.txt
   			;;
      
		4)	# Solving issue with output not being Alphabetical, planning on switching over to awk instead
  			sort -R TempFiles/Analysis.txt | uniq >> TempFiles/Output.txt
     			less TempFiles/Output.txt
     			;;
	
  		*)
    			printf "$sort_choice : Expected 1, 2, 3, or 4 ..."
       			sleep 3 ; exit 1 # Likely will change in next revision leading up to commit
	  		;;
     	esac
      
elif [[ "$response" =~ ^([Nn]|[][])$ ]]; then
	printf "Goodbye!\n"
else
      	printf "$response : Expected Y/y or N/n"
fi
