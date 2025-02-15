#!/bin/bash
#

ips=${1}


echo "Relatório de Latência"

temp_file=$(mktemp)

while read -r ip; do
    if [ -n "$ip" ]; then
        tempo_medio=$(ping -c 3 "$ip" 2>/dev/null | grep "min/avg/max" | cut -d'/' -f5)
        if [ -n "$tempo_medio" ]; then
            echo "$tempo_medio $ip" >> "$temp_file"
        else
            echo "Erro ao obter latência para o IP: $ip"
        fi
    fi
done < "$ips"

sort -nr "$temp_file" | while read -r linha; do
    tempo=$(echo "$linha" | cut -d' ' -f1)
    ip=$(echo "$linha" | cut -d' ' -f2)
    echo "IP: $ip - Tempo médio: ${tempo}ms"
done

rm "$temp_file"

