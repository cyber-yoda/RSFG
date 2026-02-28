#!/usr/bin/env bash

#
# Name: random_gen.sh
# Project: RSFG
# Description: Factor of majority and generate a random string using with awk; collapse sed and tr since awk can do what they do
#

generator() {
  # lists and arrays (wl just means wordlist)
  wl='{Billy, Duran, Brenda, Dragonfruit, Apple, Bananna, Grape} {Apple, Cheese, Potato, Pork, Bread, Butter, Beans} {Keyboard, Computer, Mouse, CPU, RAM, HDD, GPU} {Doggy, Flamingo, Frog, Kitten, Bird, Eagle, Capybara} {Autism, Epilepsy, PTSD, Depression} {Motherboard, Chipset, Periphral Component Interconnect, Pin Grid Array, Land Grid Array}'

  # Use printf instead of echo, sed to clean it up, tr it into newline-separated words, and awk 6 lines
  printf '%s' "$wl" | awk '
    BEGIN { srand(); RS="[{} ,]+" }
    /[^[:space:]]/ { a[++n] = $0 } 
    END {
        for (i=n; i>1; i--) {
            j = int(rand() * i) + 1; t=a[i]; a[i]=a[j]; a[j]=t
        }
        for (k = 1; k <=6; k++) print a[k]
    }'
}

generator
