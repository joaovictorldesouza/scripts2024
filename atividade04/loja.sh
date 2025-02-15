#!/bin/bash

tail -n +2 compras.txt | sort -t"," -k2,2nr | head -n1 | cut -d"," -f3

echo "O produto mais caro é: $(tail -n +2 compras.txt | sort -t"," -k2,2nr | head -n1 | cut -d"," -f1) | Vendido pela loja:$(tail -n +2 compras.txt | sort -t"," -k2,2nr | head -n1 | cut -d"," -f3)"

