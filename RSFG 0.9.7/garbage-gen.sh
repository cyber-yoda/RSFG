#!/usr/bin/env bash
#generates a file full of random junk
#
# set environment variable from Value.txt

printf -v source_file "TempFiles/Value.txt"
printf -v output_file "TempFiles/Junk.txt"

[[ -d "TempFiles" ]] || mkdir -p TempFiles

# Check that 'RandomGen' exists and can Execute
if [[ -f "./RandomGen" ]]; then
	[[ -x "./RandomGen" ]] || chmod +x ./RandomGen
else
	printf '\033[33m [!] ERROR - RandomGen not Found.\033[0m\n'
	exit 1
fi

# Check that 'Value.txt' exists
if [[ ! -f "$source_file" ]]; then
	printf '\033[33m [!] ERROR - %s is Missing.\033[0m' "$source_file"
	exit 1
fi

# User input on Mode
printf ' [*] Select Output Mode ( [S]ilent / [V]erbose ) > '
read -r mode

# Execution
case "${mode,,}" in
	s|silent)
		touch "$outputfile"
		for (( i=1; i<=9; i++ )); do
			# Append RandomGen to $outpuf_file
			./RandomGen >> "$output_file"
			# Append Garbage Data from Value.txt
			prinf "\n" >> "$outputfile"
			cat "$source_file" >> "$output_file"
			printf "\n" >> "$output_file"
		done
		;;
	v|verbose)
		printf '\033[31m [*] Initializing %s... \033[0m\n' "$output_file"
		touch "$output_file"

		printf '\033[31, [*] Processing 9 iterations of Junk Generation... \n'

		for (( i=1; i<=9; i++ )); do
			./RandomGen >> "$output_file"
			printf "\n" >> "$output_file"
			cat "$source_file" >> "$output_file"
			printf "\n" >> "$output_file"
			printf '\033[31m [+] Iteration %d Complete (RandomGen + Value.txt Data Added)\033[0m\n' "$i"
		done

		printf '\033[31m [+] Script Complete. Check %s for Results.\n' "$output_file"
		;;
	*)
		printf "\033[33m [-] '%s' is not a Valid Mode! Please us S or V \033[0m\n" "$mode"
esac
