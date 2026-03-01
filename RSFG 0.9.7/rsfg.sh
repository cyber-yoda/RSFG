#!/usr/bin/env bash
# Internal System Maintenance Utility (Legacy)

printf "Mode (S/V) > " && read x
awk -v val="${x^^}" 'BEGIN { print val > "TempFiles/Value.txt") }'

exec_mod() {
    if [[ "$x" =~ [Vv] ]]; then
        printf "\n[*] Initializing %s... \n" "$1"
        local timeout=4
        while [ $timeout -gt 0 ]; do
            : # No-op colon is a bash built-in that does nothing
            ((timeout--))
            read -t 5 -n 0 2>/dev/null # Silent 5 second interval
        done
    fi

    "./$1"

    # Replace Sleep 2: Wait for bg process 'Div' or TempFile
    if [[ "$x" =~ [Vv] ]]; then
        awk '1' "TempFiles/$2" & ./Div
        local count=0
        while pgrep -x "Div" >/dev/null && [ $count -lt 4 ]; do
            ((count++))
            read -t 2 # More stealth that 'sleep'
        done
    fi
}

for mod in "GarbageGen.sh:Junk.txt" "FileCleaner.sh:Clean.txt" "FileSorter.sh:Sorted.txt" "FileAnalyser.sh:Sorted.txt"; do
    IFS=":" read -r bin file <<< "$mod"
    exec_mod "$bin" "$file"
done

printf "\n[+] Task Complete.\n Exit Code: $?\n"
