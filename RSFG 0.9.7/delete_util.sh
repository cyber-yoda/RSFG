#!/usr/bin/env bash

#
# Name: delete_util.sh
# Project: RSFG
# Description: Simple script that will allow the user to delete the files in a fixed directory.
#

printf -v target "$%s/Projects/RSFG/TempFiles/deleteme.txt" "$HOME"

printf "\033[31m Delete .txt files Y/n > \033[0m" user_input
read -r user_input

# Take user input
case "${user_input,,}" in
	y|yes)
		# Check existence and delete in one line
		if [[ -f "$target" ]]; then
			printf "\033[31m [+] Found file, removing: %s\033[0m\n..." "${target##*/}"

			# rm is yes an external binary but -f prevent the script from clinging 
			# to a confirmation prompt
        	rm -rf "$target" && printf "\033[31m [+] Removal Successful.\033[0m\n" || printf "\033[33m Failed to Remove File.\033[0m\n"
		else
        	printf "\033[33m [-] Target File not found: %s\033[0m\n" "$target"
		fi
		;;

	n|no)
		printf "\033[33m [-] Operation Aborted. No Files Deleted.\n"
		;;
		
	*)
		# Using %q in printf safely escape weird garbage character period.
		printf '\033[33m [-] %q : Expected y/n\033[0m\n' "$user_input"
		exit 1
		;;
esac
