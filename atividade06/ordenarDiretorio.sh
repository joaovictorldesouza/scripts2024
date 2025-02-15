#!/bin/bash
#

dir="$1"

if [ -z "$dir" ]; then
    echo "Caminho inválido!!"
    exit 1
fi

if [ ! -d "$dir" ]; then
    echo "Diretório inválido!!"
    exit 1
fi

find "$dir" -type f -name "*.txt" | while read -r arquivo; do
    linhas=$(wc -l < "$arquivo")
    echo "$linhas $arquivo"
done | sort -n | while read -r linhas arquivo; do
    echo "Arquivo: $arquivo - Linhas: $linhas"
done
