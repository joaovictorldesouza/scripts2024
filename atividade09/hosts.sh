#!/bin/bash

HOSTS_DB="hosts.db"

function adicionar() {
    echo "$hostname;$ip" >> "$HOSTS_DB"
    echo "Adicionado: $hostname;$ip"
}

function remover() {
    sed -i "/^$1;/d" "$HOSTS_DB"
    echo "Removido: $1"
}

function listar() {
    cat "$HOSTS_DB"
}

function procurar() {
    grep "^$1;" "$HOSTS_DB" | cut -d';' -f2
}

function procurar_reverso() {
    grep ";$1$" "$HOSTS_DB" | cut -d';' -f1
}

hostname=""
ip=""
buscar=""
buscar_reverso=""

while getopts "a:i:d:lr:" OPTVAR; do
    case "$OPTVAR" in
        l)
            listar
            exit
            ;;
        d)
            remover "$OPTARG"
            exit
            ;;
        a)
            hostname="$OPTARG"
            ;;
        i)
            ip="$OPTARG"
            ;;
        r)
            buscar_reverso="$OPTARG"
            ;;
        *)
            echo "Opção inválida"
            exit 1
            ;;
    esac
done

if [ -n "$hostname" ] && [ -n "$ip" ]; then
    adicionar
elif [ -n "$buscar_reverso" ]; then
    procurar_reverso "$buscar_reverso"
elif [ -n "$1" ]; then
    procurar "$1"
fi

