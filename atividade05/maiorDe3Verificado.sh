#!/bin/bash

shopt -s extglob

a=${1}
b=${2}
c=${3}

if ! [[ ${a} == ?(+|-)+([0-9]) ]]; then
    echo "Opa!!! ${n1} não é número."
    exit 1
fi

if ! [[ ${b} == ?(+|-)+([0-9]) ]]; then
    echo "Opa!!! ${b} não é número."
    exit 1
fi

if ! [[ ${c} == ?(+|-)+([0-9]) ]]; then
    echo "Opa!!! ${c} não é número."
    exit 1
fi


if test ${a} -ge ${b} -a ${a} -ge ${c}; then
   echo "O maior número é: ${a}"
else
   if test ${b} -ge ${a} -a ${b} -ge ${c}; then
	echo "O maior número é: ${b}"
   else
	echo "O maior número é: ${c}"
   fi
fi
