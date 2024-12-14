function cut_k(text,        i, l, v, arr){
    gsub("[^ ,]+[ ]*\\([0-9]+\\)(([ ]+- [^\n]+)|,)", "&\n", text)
    l = split(text, arr, "\n")
    for (i=1; i<=l; ++i){
        v = arr[i]
        gsub(/^[ \t\b\v\n]+|[ \t\b\v\n,]+$/, "", v)
        if (v != "") {
            if (UNIQ[v] != 1) print v
            UNIQ[v] = 1
        }
    }
}
{
    cut_k($0)
}
