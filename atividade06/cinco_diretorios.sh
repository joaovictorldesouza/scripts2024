#!/bin/bash
#

mkdir -p cinco

for i in {1..5}; do
    mkdir -p "cinco/dir$i"

    for j in {1..4}; do
       for k in $(seq 1 $j); do
         echo "$j"
       done > "cinco/dir$i/arq$j.txt"
    done
done
