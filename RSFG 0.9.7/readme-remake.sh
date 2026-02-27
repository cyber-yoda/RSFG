# This is not the readme file lmao
# more of a redundancy in the change the readme file
# does not already exist

awk 'BEGIN { system("touch README.md") }'
markdown=$( awk '{ chars += length($0) +1 } END { print chars }' README.md | awk '{ gsub(/[[:alpha:]]/, ""); print }' | awk '{ gsub(/\./, ""); print }')


if [ "$markdown" -gt 2 ]; then

	printf '[!] README.txt exists \n'

else

	printf '[*] Recreating README.txt \n'

	printf "%s\n\n" "Silly bash scripts made I have.
	Program called 'RSFG'; Really-Silly-File-Generator it is.
	Run you can, by opening this folder in Terminal and running:

		cd rsfg-refactor
		chmod 700 rsfg
		./rsfg

	Have fun. Have strange open file errors, alter environment variable
	at start of scripts to match your system be sound solution.
	Look through codebase before run any, to know what it nature.
	Smart to do for random stuff dowloaded off internet." > README.md
fi
