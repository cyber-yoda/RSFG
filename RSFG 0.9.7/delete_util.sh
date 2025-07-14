#!/usr/bin/env bash

#
# Name: delete_util.sh
# Project: RSFG
# Description: Simple script that will allow the user to delete the files in a fixed directory.
#

printf "\nDo you want to clean out the  files? y/N: " 	# asks for user input 
read d							# records the what the user entered to the d varible 
printf "\n"

if [ $d = 'Y' ] || [ $d = 'y' ]; then #if the user enters yes, it will  delete all the text files in the folder and uses the '||' or operator to allow both upper and lower case Y as a valid responce.
				       
        rm -iv ~/Downloads/*.txt # uses the rm command with the prompt and verbose flags to prompt before deletion each file ending in .txt in the ~/Downloads directory.
	
elif [ $d = 'N' ] || [ $d = 'n' ]; then
	printf " [-] No Files Deleted... \n"

elif [ $d = 'Y' ] || [ $d = 'y' ]; then
	printf " [+] Deleted Files ... \n"

else
	printf "%s: Expected y\N" "$d"
fi
