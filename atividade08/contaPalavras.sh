#!/bin/bash
#

echo -n "Informe o arquivo: "
read arquivo

if [ ! -f "$arquivo" ];
   then
   echo "Erro: O arquivo '$arquivo' não existe."
   exit 1
fi

cat "$arquivo" | tr -d '.,!?' | tr '[:space:]' '\n' | grep -v '^$' | sort | uniq -c | sort -nr | while read -r count word; do
   echo "$word: $count"
done
