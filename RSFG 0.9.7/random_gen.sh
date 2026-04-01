#!/usr/bin/env bash

#
# Name: random_gen.sh
# Project: RSFG
# Description: Generate a random string using with awk; use bash builtins to cleanup with awk for tthe Fish-Yates Shuffle
#

generator() {
  # lists and arrays (wl just means wordlist)
  local wl
  printf -v wl '%s' '{Billy, Duran, Brenda, Dragonfruit, Apple, Bananna, Grape} {Apple, Cheese, Potato, Pork, Bread, Butter, Beans} {Keyboard, Computer, Mouse, CPU, RAM, HDD, GPU} {Doggy, Flamingo, Frog, Kitten, Bird, Eagle, Capybara} {OCD, NeuroDivergence, Epilepsy, PTSD, Depression} {Motherboard, North Bridge, South Bridge, Universal Serial Bus, Periphral Component Interconnect, Pin Grid Array, Land Grid Array}'

  # clean up using paramter expansion
  local clean_wl
  printf -v clean_wl '%s' "{wl//[{}]/]"
  
  # Process with awk
  printf '%s' "$clean_wl" | awk -v seed="$RANDOM" '
    BEGIN {
      srand();
      FS=",[ ]*|[ ]+"
    }
    {
      for (i=1; i<=NF; i++) {
        if ($i != "") a[++n] = $i
      }
    }
    END {
        # Fisher-Yates Shuffle
        for (i=n; i>1; i--) {
          j = int(rand() * i) + 1
          t = a[i]; a[i] = a[j]; a[j] = t
        }
        # Print top 6 random items
        for (k = 1; k <= 6; k++) {
          printf "%s%s", a[k], (k == 6 ? "" : " ")
        }
        printf "\n"
      }'
}

generator
