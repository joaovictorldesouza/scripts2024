BEGIN {
    FS=":";
    print "Aluno - Situação - Média";
}

NR > 1 {
    media = ($2 + $3 + $4) / 3;

    if (media >= 7) {
        situacao = "Aprovado";
    } else if (media >= 5) {
        situacao = "Final";
    } else {
        situacao = "Reprovado";
    }

    print $1 " - " situacao " - " media;

    soma1 += $2;
    soma2 += $3;
    soma3 += $4;
    count++;
}

END {
    print "Média das Provas: " soma1/count " " soma2/count " " soma3/count;
}

