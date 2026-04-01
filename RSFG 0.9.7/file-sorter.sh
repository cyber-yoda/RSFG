#!/usr/bin/env bash
#breaks down and sorts Clean.txt
#

printf -v input_file "TempFiles/Value.txt"
printf -v data_src "TempFiles/Clean.txt"
printf -v data_dest "TempFiles/Sorted.txt"

# Read User Input from file using Builtin Redirection
if [[ -f "$input_file" ]]; then
	read -r b < "$input_file"
else
	printf '\033[33m [-] ERROR: %s not found.\033[0m\n' "$input_file"
	exit 1
fi

case "${b,,}" in
	s)
		tr ' ' '\n' < "$data_src" | tr -s '\n' | sort > "$data_dest"
		;;
	v)
		printf '\033[32m [*] Sorting %s...\n' "$data_src"

		# Tuned up Pipeline
		tr ' ' '\n' < "$data_src" | tr -s '\n' | sort > "$data_dest"

		printf '\033[31m \n [+] Script Completed\n\033[0m\n'
		;;
	
	*)
		printf "\033[33m [-] '%s' : Expected S/s or V/v \033[0m\n" "$b"
		exit 1
		;;
esac
