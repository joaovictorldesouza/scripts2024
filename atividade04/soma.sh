#!/bin/bash
#
tail -n +2 compras.txt | cut -d"," -f2 | tr -d ' ' | tr '\n' '+' | sed 's/+$/\n/' | bc

echo "A soma de todos os produtos na lista é: RS $(tail -n +2 compras.txt | cut -d"," -f2 | tr -d ' ' | tr '\n' '+' | sed 's/+$/\n/' | bc),00"
