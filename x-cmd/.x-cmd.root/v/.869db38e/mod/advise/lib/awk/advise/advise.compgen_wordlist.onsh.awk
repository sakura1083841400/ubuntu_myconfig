function comp_advise_str_style_onsh( v, d, sep,      _res ){
    if ( v == "" ) return
    if ((d != "") && ( ADVISE_WITHOUT_DESC != 1 )) {
        _res = sprintf("{ \"Value\": %s, \"Display\": %s, \"Description\": %s, \"Style\": \"bg:default fg:ansicyan\" }", \
                jqu(v sep), jqu(v), jqu(d))
    } else {
        _res = sprintf("{ \"Value\": %s, \"Display\": %s, \"Description\": \"\", \"Style\": \"bg:default fg:ansigreen\" }", \
                jqu(v sep), jqu(v))
    }
    return _res
}

BEGIN{
    NO_COLOR = ENVIRON[ "NO_COLOR" ]
}

( arr[ $1 ] != 1 ){
    end_sep = $1
    v = candidate_prefix $2
    d = $3
    if (( v == "" ) || ( arr[ v ] == 1 ) || ((current != "") && index(v, current) <= 0)) next

    NUM ++
    w = length(v)
    arr[ NUM, "VAL" ] = v
    arr[ NUM, "DESC" ] = d
    arr[ NUM, "END_SEP" ] = end_sep

    if (MAX_W < w) MAX_W = w
    if ( NUM >= maxitem ) exit(0)
}

END{
    printf "["
    if (NUM > 0) {
        printf("%s", comp_advise_str_style_onsh( arr[1, "VAL"], arr[1, "DESC"], arr[1, "END_SEP"] ))
        for (i=2; i<=NUM; ++i){
            str = comp_advise_str_style_onsh( arr[i, "VAL"], arr[i, "DESC"], arr[i, "END_SEP"] )
            if ( str != "") printf(", %s",  str )
        }
    }
    printf "]\n"
}
