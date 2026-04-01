#!/usr/bin/env bash

#
# Project: file-analyzer.sh
# Author: Cyber-Yoda
# Description: Refactored to use arrays, efficent redirectitons, and Bash builtins.
#

# Variable Declaration
printf -v src "TempFiles/Sorted.txt"
printf -v work_file "TempFiles/SortedNB.txt"
printf -v analysis_log "TempFiles/Analysis.txt"
printf -v final_out "TempFiles/Output.txt"

# Replaced entire banner/user prompt with 2 lines vs 3
printf '\033[31m Analyze Output? Y/n > \033[31m\n'
read -r response

# Handle Defalt (empty) as 'Yes'
[[ -z "$response" ]] && response="y"

# Refactor Main Execution Logic to still use Regular Expression
if [[ $response =~ ^([Yy]|[Yy][Ee][Ss])$ ]]; then
	# Strip away blank lines using 'grep -v' and redirect into work_file
	grep -v '^[[:blank:]]*$' "$src" > "$work_file"

	# Clear away prior analysis to prevent appending old data
	: > "$analysis_log"

	# Read file into array instead of disk thrashing `sed -i '1d' 
	mapfile -t lines < "$work_file"

	printf '\033[31m [*] Analyzing Word Frequencies...\033[0m\n'

	for search_term in "${lines[@]}"; do
		read -ra words <<< "$search_term"
		word_count="${#words[@]}"

		# Format and Save to Analysis Log
		printf "%-4s %s\n" "$word_count" "$search_term" >> "$analysis_log"
	done

	# Sort
	printf '\n\033[31m How Do You want to Sort the Output?\033[0m\n'
	printf '\033[31m 1: Alphabetical\n 2: Biggest First \n 3: Smallest First \n 4: Random \033[0m\n'
	printf '\033[31m [*] Select Sort Choice > \033[0m\n'
	read -r sort_choice

	case "$sort_choice" in
		1) printf -v opts "" ;;
		2) printf -v opts "-rn" ;;
		3) printf -v opts "-n" ;;
		4) printf -v opts "-R" ;;
		*) 
			printf '\033[33m [-] ERROR %s : Invalid Choice. Exiting...\033[0m\n' "$sort_choice"
			exit 1
			;;
	esac

	# Run sort and uniq in one pipeline
	sort $opts "$analysis_log" | uniq > "$final_out"

	# Open result
	less "$final_out"

elif [[ "$response" =~ ^[Nn] ]]; then
	printf 'Goodbye!\n'
else
	printf "\033[33m [-] ERROR %s : Expected Y/y or N/n \033[0m\n" "$response"
fi
