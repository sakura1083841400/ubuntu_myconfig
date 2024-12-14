

NR==1{
    analyse_header( attr )
    # print "abc" >"/dev/stderr"
    # print_utf8()
    # print "aaa " attrl
    print_normal()
}

function print_normal(){
    while (1) {
        line = $0
        for (i=1; i<attrl; ++i) {
            b = attr[ i ]
            e = attr[i+1]
            if (i<attrl-1) {
                elem = substr(line, b, e-b)
                gsub("[ \t]+$", "", elem)
                printf("%s,", csv_quote_ifmust(elem))
            } else {
                elem = substr(line, b)
                gsub("[ \t]+$", "", elem)
                printf("%s\n", csv_quote_ifmust(elem))
            }
        }

        if (! gli_next()) break
    }
}

function print_utf8(){
    while (1) {
        line = $0
        for (i=1; i<attrl; ++i) {
            elem = wcstruncate(line, attr[i+1] - attr[i])
            if (i<attrl-1) {
                elem = wcstruncate(line, attr[i+1] - attr[i])
                line = substr(line, length(elem)+1)
                gsub("[ \t]+$", "", elem)
                printf("%s,", csv_quote_ifmust(elem))
            } else {
                elem = substr(line, b)
                gsub("[ \t]+$", "", elem)
                printf("%s\n", csv_quote_ifmust(elem))
            }
        }

        if (! gli_next()) break
    }
}
