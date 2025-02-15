#!/bin/bash
#
echo "----------------------------------------------------------------"
echo "Encontra todas as linhas que não contém SSHD"
#
grep -v 'sshd' auth.log
#
#
echo "----------------------------------------------------------------"
echo "Todas as linhas com login bem-sucedido:"
#
grep -E 'sshd.*Accepted.*for j\w' auth.log
#
#
echo "----------------------------------------------------------------"
echo "Tentativas de login via root no sshd:"
#
grep -E 'sshd.*root' auth.log
#
#
echo "----------------------------------------------------------------"
echo "Logins bem sucedidos nos dias 11 e 12 de Outubro:"
#
grep -E 'Oct (11|12).*Accepted' auth.log
