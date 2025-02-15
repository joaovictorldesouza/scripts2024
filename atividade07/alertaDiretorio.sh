#!/bin/bash

time=${1}
dir=${2}

qnti=$(ls "$dir" | wc -l)
prev_files=$(ls "$dir")

while true; do
    sleep "$time"

    qnta=$(ls "$dir" | wc -l)
    curr_files=$(ls "$dir")
    data=$(date "+%Y-%m-%d %H:%M:%S")

    if [[ $qnti -gt $qnta ]]; then
        removed_files=$(comm -23 <(echo "$prev_files") <(echo "$curr_files"))
        echo "[$data] Alteração! $qnti->$qnta. Removidos: $removed_files" | tee -a dirSensors.log
    elif [[ $qnti -lt $qnta ]]; then
        added_files=$(comm -13 <(echo "$prev_files") <(echo "$curr_files"))
        echo "[$data] Alteração! $qnti->$qnta. Adicionados: $added_files" | tee -a dirSensors.log
    fi

    qnti=$qnta
    prev_files=$curr_files
done
