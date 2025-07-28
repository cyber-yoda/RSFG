#!/usr/bin/env bash

#
# Name: delete_util.sh
# Project: RSFG
# Description: Simple script that will allow the user to delete the files in a fixed directory.
#

read -p "Delete .txt files Y/n > " user_input

target_file="$HOME/Projects/RSFG/TempFiles/deleteme.txt"

if [[ "$user_input" =~ ^[Yy]$ ]]; then

    if [[ -f "$target_file" ]]; then
        printf " [+] Found file, deleting... \n"
        rm -Iv "$target_file"
        printf " [+] File deleted successfully.\n"
	
    else
        printf " [-] No such file: %s\n" "$target_file"
	
    fi

elif [[ "$user_input" =~ ^[Nn]$ ]]; then
    printf " [-] No files deleted... \n"

else
    printf "%s: [-] Expected: y or n\n" "$user_input"

fi
