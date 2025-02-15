#!/bin/bash

operacao=${1}
nome=${2}
email=${3}
AGENDA="agenda.db"

if test "${operacao}" = "adicionar"; then

   if [ ! -f "$AGENDA" ]; then
       touch "$AGENDA"
       echo "Arquivo criado!!!"
   fi

    if [ -z "${nome}" ] || [ -z "${email}" ]; then
        echo "Erro: Nome e email devem ser fornecidos."
        echo "Uso: $0 adicionar \"Nome\" \"Email\""
        exit 1
    fi
    echo "${nome}:${email}" >> "$AGENDA"
    echo "Usuário ${nome} adicionado."
fi

if test "${operacao}" = "listar"; then
    if [ ! -s "$AGENDA" ]; then
        echo "Arquivo vazio!!!"
    else
        cat "$AGENDA"
    fi
fi

if test "${operacao}" = "remover"; then
    if [ -z "${email}" ]; then
        echo "Erro: Email deve ser fornecido."
        echo "Uso: $0 remover \"Email\""
        exit 1
    fi

    if grep -q ":${email}$" "$AGENDA"; then
        # Remover a linha correspondente
        sed -i "/:${email}$/d" "$AGENDA"
        echo "Usuário com e-mail ${email} removido."
    else
        echo "Erro: O e-mail ${email} não está cadastrado."
    fi
fi


if test "${operacao}" != "adicionar" && test "${operacao}" != "listar" && test "${operacao}" != "remover"; then
   echo "Digite apenas: adicionar, listar ou remover."
   exit 1
fi
