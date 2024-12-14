{
    jiparse_after_tokenize(o, $0)
}

END{
    sep = juq("\""ENVIRON["sep"]"\"")
    _kp = jpath(ENVIRON["kp"])
    l = o[ _kp L]
    if(l == "") {
        log_error("jo", "Your keypath is wrong")
        exit(1)
    }
    if( o[_kp] != "[") {
        log_error("jo", "The value is not a list")
        exit(1)
    }
    for(i=1; i<=l; ++i) {
            if (o[ _kp SUBSEP "\""i"\""] ~ "^\"") printf("%s" sep, juq(o[ _kp SUBSEP "\""i"\""] ))
            else printf("%s" sep, o[ _kp SUBSEP "\""i"\""] )
    }
}



