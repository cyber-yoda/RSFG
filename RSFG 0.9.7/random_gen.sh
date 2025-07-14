#!/usr/bin/env bash

#
# Name: random_gen.sh
# Project: RSFG
# Description: Factor of majority and generate a random string using awk, sed, and tr
#

generator() {
  # lists and arrays
  wordlist='{Billy, Duran, Brenda, Dragonfruit, Apple, Bananna, Grape} {Apple, Cheese, Potato, Pork, Bread, Butter, Beans} {Keyboard, Computer, Mouse, CPU, RAM, HDD, GPU} {Doggy, Flamingo, Frog, Kitten, Bird, Eagle, Capybara} {Autism, Epilepsy, PTSD, Depression} {Motherboard, Chipset, Periphral Component Interconnect, Pin Grid Array, Land Grid Array}'

  # Use printf instead of echo, sed to clean it up, tr it into newline-separated words, and awk 6 lines
  printf '%s\n' "$wordlist" | \
    sed -e 's/[{}]//g' -e 's/,//g' | \
    tr ' ' '\n' | \
    awk -v n=9 'BEGIN {srand()} {a[NR]=$0} END {
        # Fisher-Yates Shuffle
        for (i=NR; i > 1; i--) {
            j = int(rand() * i) + 1
            tmp = a[i]; a[i] = a[j]; a[j] = tmp
        }
        for (k = 1; k <=6 && k <= NR; k++) {
            print a[k]
        }
    }'
}

generator
