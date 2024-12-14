# shellcheck shell=sh disable=SC3043,SC1090,SC2154,SC3054
___x_cmd_advise_man_completer___zsh_lazyload(){
    local x_=; ___x_cmd_advise_man_which___completion_getfile_ "${words[1]}"
    { [ -r "$x_" ] && [ -f "$x_" ] ;} || return
    . "$x_" 2>/dev/null
}

___x_cmd_advise_man_completer___zsh_load(){
    { [ -r "$___X_CMD_ADVISE_MAN_COMPLETIONS_FOLDER_SRC" ] && [ -d "$___X_CMD_ADVISE_MAN_COMPLETIONS_FOLDER_SRC" ] ;} || return 0
    local i; for i in "$___X_CMD_ADVISE_MAN_COMPLETIONS_FOLDER_SRC"/*; do
        i="${i##*/}"
        compdef ___x_cmd_advise_man_completer___zsh_lazyload "${i#_}"
    done
}

if [ -n "$ZSH_VERSION" ]; then
    command -v compdef 2>/dev/null 1>&2 || return    
    ___x_cmd_advise_man_completer___zsh_load
fi
