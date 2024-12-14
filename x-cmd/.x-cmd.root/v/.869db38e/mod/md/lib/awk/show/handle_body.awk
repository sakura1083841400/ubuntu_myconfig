
function md_handle_body( line, output_arr ){
    line = md_body_transform_italic(line)
    line = md_body_transform_bold(line)
    line = md_body_transform_bold_italic(line)
    line = md_body_transform_strikethrough(line)
    line = md_body_transform_url_email(line)
    line = md_body_transform_link(line)
    line = md_body_transform_pic(line)
    line = md_body_transform_abstract(line)
    line = md_body_transform_task_list_done(line)
    line = md_body_transform_task_list_undone(line)
    line = md_body_transform_quote(line)

    return md_output( md_body_transpose(line), output_arr )
}

function md_body_transpose( line ){
    # handle the data
    gsub("&nbsp;",      " ",    line)
    gsub("&lt;",        "<",    line)
    gsub("&gt;",        ">",    line)
    gsub("&amp;",       "\\&",  line)
    gsub("&quot;",      "\"",   line)
    gsub("&apos;",      "'",    line)
    gsub("&cent;",      "￠",   line)
    gsub("&pound;",     "£",    line)
    gsub("&yen;",       "¥",    line)
    gsub("&euro;",      "€",    line)
    gsub("&sect;",      "§",    line)
    gsub("&copy;",      "©",    line)
    gsub("&reg;",       "®",    line)
    gsub("&times;",     "×",    line)
    gsub("&divide;",    "÷",    line)
    gsub("&trade;",     "™",    line)
    gsub("&ldquo;",     "“",    line)
    gsub("&rdquo;",     "”",    line)
    gsub("&lsquo;",     "‘",    line)
    gsub("&rsquo;",     "’",    line)
    gsub("&ndash;",     "–",    line)
    gsub("&mdash;",     "—",    line)
    return line
}

# 倾斜字体
function md_body_transform_italic( text,     s1, s2, r, _regex1, _regex2 ){
    _regex1 = "\\*([^ *][^*]*[^ *]|[^ *])\\*"
    _regex2 = "(^| )_([^ ].*[^ ]|[^ ])_( |$)"
    while (match(text, "("_regex1 "|" _regex2 ")")) {
        s1 = substr(text, 1, RSTART-1)
        s2 = substr(text, RSTART, RLENGTH)
        gsub(STR_TERMINAL_ESCAPE033_LIST, "", s2)
        text = substr(text, RSTART+RLENGTH)
        r = r s1 "\033[38;5;214m" UI_TEXT_ITALIC s2 "\033[0m"
    }
    return ("" == r) ? text : r text
}

# 加粗字体
function md_body_transform_bold( text,     s1, s2, r, _regex1, _regex2 ){
    _regex1 = "\\*("STR_TERMINAL_ESCAPE033_LIST")?\\*([^ *][^*]*[^ *]|[^ *])\\*("STR_TERMINAL_ESCAPE033_LIST")?\\*"
    _regex2 = "(^| )_("STR_TERMINAL_ESCAPE033_LIST")?_([^ ].*[^ ]|[^ ])_("STR_TERMINAL_ESCAPE033_LIST")?_( |$)"
    while (match(text, "("_regex1 "|" _regex2 ")")) {
        s1 = substr(text, 1, RSTART-1)
        s2 = substr(text, RSTART, RLENGTH)
        gsub(STR_TERMINAL_ESCAPE033_LIST, "", s2)
        text = substr(text, RSTART+RLENGTH)
        r = r s1 "\033[38;5;117m" UI_TEXT_BOLD s2 "\033[0m"
    }
    return ("" == r) ? text : r text
}

# 倾斜加粗字体
function md_body_transform_bold_italic( text,     s1, s2, r, _regex1, _regex2 ){
    _regex1 = "\\*("STR_TERMINAL_ESCAPE033_LIST")?\\*\\*([^ *][^*]*[^ *]|[^ *])\\*\\*("STR_TERMINAL_ESCAPE033_LIST")?\\*"
    _regex2 = "(^| )_("STR_TERMINAL_ESCAPE033_LIST")?__([^ ].*[^ ]|[^ ])__("STR_TERMINAL_ESCAPE033_LIST")?_( |$)"
    while (match(text, "("_regex1 "|" _regex2 ")")) {
        s1 = substr(text, 1, RSTART-1)
        s2 = substr(text, RSTART, RLENGTH)
        gsub(STR_TERMINAL_ESCAPE033_LIST, "", s2)
        text = substr(text, RSTART+RLENGTH)
        r = r s1 "\033[38;5;141m" UI_TEXT_ITALIC UI_TEXT_BOLD  s2  "\033[0m"
    }
    return ("" == r) ? text : r text
}

# 文字删除
function md_body_transform_strikethrough( text,     s1, s2, r ){
    while (match(text, "~~(.*?)~~")) {
        s1 = substr(text, 1, RSTART-1)
        s2 = substr(text, RSTART, RLENGTH)
        text = substr(text, RSTART+RLENGTH)
        r = r s1 "\033[38;5;244;9m"   s2 "\033[0m"
    }
    return ("" == r) ? text : r text
}

# 高亮内容显示，单行代码命令
function md_body_transform_quote( text,     s1, s2){
    while (match(text, "`[^`]+`")) {
        s1 = substr(text, 1, RSTART-1)
        s2 = substr(text, RSTART+1, RLENGTH-2)
        gsub(STR_TERMINAL_ESCAPE033_LIST, "", s2)
        text = s1 "\033[48;2;48;48;48m\033[38;2;255;80;95m" s2  "\033[0m" substr(text, RSTART+RLENGTH)
    }
    return text
}

# URLs and Email 链接地址
function md_body_transform_url_email( text,     s1, s2, r ){
    while (match(text, "((^| )" RE_URL_HTTP "|(^| )" RE_URL_HTTPS "|(^| )" RE_EMAIL ")" )) {
        s1 = substr(text, 1, RSTART-1)
        s2 = substr(text, RSTART, RLENGTH)
        text = substr(text, RSTART+RLENGTH)
        r = r s1 "\033[38;5;209m"  s2  "\033[0m"
    }
    return ("" == r) ? text : r text
}

# 链接
function md_body_transform_link( text,     s1, s2, r ,_regex ){
    _regex = "\\[[^\\]]*\\]\\([^)]+\\)"
    while (match(text, "([^!]|^)"_regex )) {
        s1 = substr(text, 1, RSTART-1)
        s2 = substr(text, RSTART, RLENGTH)
        text = substr(text, RSTART+RLENGTH)
        gsub(STR_TERMINAL_ESCAPE033_LIST, "", s2)
        r = r s1 "\033[38;5;209m"  s2  "\033[0m"
    }
    return ("" == r) ? text : r text
}

# 图片
function md_body_transform_pic( text,     s1, s2, r,_regex  ){
    _regex = "\\[[^\\]]*\\]\\([^)]+\\)"
    while (match(text, "!"_regex )) {
        s1 = substr(text, 1, RSTART-1)
        s2 = substr(text, RSTART, RLENGTH)
        text = substr(text, RSTART+RLENGTH)
        gsub(STR_TERMINAL_ESCAPE033_LIST, "", s2)
        r = r s1 "\033[38;5;118m" s2 "\033[0m"
    }
    return ("" == r) ? text : r text
}

# 引用
function md_body_transform_abstract( text,     s, r ){
    while (match(text, "^[ ]*(>[ ]?)+")) {
        s = substr(text, 1, RLENGTH)
        gsub(">[ ]*", "│ ", s)
        text = s substr(text, RLENGTH+1)
    }
    return text
}

# 已完成任务列表
function md_body_transform_task_list_done( text,     s1, r ){

    while (match(text, "^[ ]*[•*+\\-] (\\[x]) ")) {
        text = substr(text, RSTART+RLENGTH)
        r =  "[ \033[38;5;34m✓\033[0m ]"          #"✅"
    }
    return ("" == r) ? text : r " " text
}

# 未完成任务列表
function md_body_transform_task_list_undone( text,     s1, r ){
    while (match(text, "^[  ]*[•*+\\-] (\\[ ]) ")) {
        text = substr(text, RSTART+RLENGTH)
        r = r   "[   ]"        #"❌"
    }
    return ("" == r) ? text : r " " text
}

