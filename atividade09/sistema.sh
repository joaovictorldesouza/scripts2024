#!/bin/bash

menu() {
    clear
    echo "===== Monitor de Sistema ====="
    echo "1) Tempo ligado"
    echo "2) Últimas mensagens do Kernel"
    echo "3) Memória Virtual"
    echo "4) Uso da CPU por núcleo"
    echo "5) Uso da CPU por processos"
    echo "6) Uso da Memória Física"
    echo "7) Sair"
    echo "================================"
    echo -n "Escolha uma opção: "
}

while true; do
    menu
    read opcao
    case $opcao in
        1) 
            clear
            echo "=== Tempo ligado ==="
            uptime
            ;;
        2) 
            clear
            echo "=== Últimas mensagens do Kernel ==="
            dmesg | tail -n 10
            ;;
        3) 
            clear
            echo "=== Memória Virtual ==="
            vmstat 1 10
            ;;
        4) 
            clear
            echo "=== Uso da CPU por núcleo ==="
            mpstat -P ALL 1 5
            ;;
        5) 
            clear
            echo "=== Uso da CPU por processos ==="
            pidstat 1 5
            ;;
        6) 
            clear
            echo "=== Uso da Memória Física ==="
            free -m
            ;;
        7) 
            echo "Saindo..."
            exit 0
            ;;
        *) 
            echo "Opção inválida! Tente novamente."
            ;;
    esac
    echo -n "Pressione Enter para continuar..."
    read
done

