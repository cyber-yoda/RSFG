#!/usr/bin/env bash
# This is not the readme file lmao
# more of a redundancy in the change the readme file
# does not already exist


# variable declaration using printf -v
printf -v target_file "README.md"

# existence and size checking (uses builtins)
[[ -f "$target_file" ]] || : > "$target_file"

# -s to check if file exists and has a greater size than zero
# builtin-like check via `wc -c`
printf -v markdown "%d" "$(wc -c < "$target_file")"

if (( markdown > 2 )); then
	printf '\033[31m [+] %s Exists and contains Data.\033[0m\n' "$target_file"
else
	printf '\033[33m [*] Recreating missing file %s...\033[0m\n' "$target_file"

	cat <<- 'EOF' > "$target_file"
		Silly bash scripts made I have.
		Program called 'RSFG'; Really-Silly-File-Generator it is.
		Run you can, by opening this folder in Terminal and running:

			cd rsfg-refactor
			chmod 700 rsfg
			./rsfg

		Have fun. Have strange open file errors, alter environment variable
		at start of scripts to match your system be sound solution.
		Look through codebase before run any, to know what it nature.
		Smart to do for random stuff dowloaded off internet. > README.md
		EOF
fi
