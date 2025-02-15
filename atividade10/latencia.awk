BEGIN {
    print "Relatório de Latência";
}

{
    cmd = "ping -c 3 " $1 " 2>/dev/null | grep 'min/avg/max' | cut -d'/' -f5";
    cmd | getline tempo_medio;
    close(cmd);

    if (tempo_medio != "") {
        print $1, tempo_medio "ms";
    } else {
        print "Erro ao obter latência para o IP:", $1;
    }
}

