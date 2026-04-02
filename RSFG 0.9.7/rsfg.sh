#!/usr/bin/env bash
# Internal System Maintenance Utility (Refactor)

# Variable Declaration + Input
printf "\033[31m Mode (S/V) > \033[0m"
read x

# Convert to Uppcase using builtin parameter expansion and append to file
printf "%s\n" "${x^^}" > "TempFiles/Value.txt"

# Execute Func
exec_mod() {
    local bin="$1"
    local log_file="$2"

    # Autofix permissions and builtins
    [[ -f "./$bin" && ! -x "./$bin" ]] && chmod +x "./bin"

    if [[ "$x" =~ [Vv] ]]; then
        printf '\033[31m [*] Initializing %s... \033[0m\n' "$bin"
        # Bultin to replace sleep/wait logic
        for ((timeout=4; timeout>0; timeout--)); do
            read -t 1 -n 0 2>/dev/null # sub second precision wait
        done
    fi

    # Execute the binary
    "./$bin"

    if [[ "$x" =~ [Vv] ]]; then
        # Use builtin 'cat' equiv with redirection rather than awk
        while IFS=read -r line; do
            printf "%s\n" "$line"
        done < "TempFile/$log_file" &

        # Reference the bg PID (builtin $!)
        local div_pid=$!
        ./Div &
        local div_exec_pid=$!

        local count=0

        while kill -0 $div_exec_pid 2>/dev/null && ((count < 4)); do
            ((count++))
            read -t 1
        done
    fi
}

# Main Loop
# Builtin Array for cleaner iterating

# Format: 
# modules=(
#    "scriptname.sh:filename.txt"
#     ...
#     )
modules=(
    "garbage-gen.sh/Junk.txt"
    "file-cleaner.sh/Clean.txt"
    "file-sorter.sh/Sorted.txt"
    "file-analyzer.sh/Sorted.txt"
)

for mod in "${modules[@]}"; do
    # Built str manipulation for splitting values so not external tools get utilized
    printf -v bin "${mod%%s:*}"
    printf -v file "${mod#*:}"
    exec_mod "$bin" "$file"
done

printf '\033[31m [+] Task Complete.\n'
printf '\033[31m [+] Exit Code: %d\033[0m\n' "$!"
