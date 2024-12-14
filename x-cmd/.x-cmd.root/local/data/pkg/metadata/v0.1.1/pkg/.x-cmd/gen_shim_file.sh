# shellcheck    shell=dash
x log init x_cmd_pkg
xrc shim
# TODO: Use ___x_cmd_pkg_sphere_shim_gen
___x_cmd_pkg_shim_gen(){
    local source="$___X_CMD_PKG___META_TGT"
    local default_target="$___X_CMD_PKG___META_TGT/shim_bin"
    local adaptive_target="$___X_CMD_PKG___META_TGT/adaptive_shim_bin"

    local ___X_CMD_PKG_SHIM_BIN_OPTS=''
    local mode=; local code=; local target=; local x_=
    while [ $# -gt 0 ]; do
        case "$1" in
            --mode)     mode=$2;                shift 2 ;;
            --code)     code=$2;                shift 2 ;;
            --var)
                        x cmdstr ___X_CMD_PKG_SHIM_BIN_OPTS "${2}"
                                                shift 2 ;;
            --bin_dir)
                        source="$___X_CMD_PKG___META_TGT/${2}"
                        ! [ "${source%/*}" = "${source%?}" ] || source="$___X_CMD_PKG___META_TGT"
                                                shift 2 ;;
            --bin_file) shift 1;                break ;;
            *)                                  return 1 ;;
        esac
    done

    x mkdirp  "$default_target"
    ! [ "$mode" = "adaptive" ] || x mkdirp  "$adaptive_target"
    x_cmd_pkg:info                    \
        --source "$source/"           \
        --shim_bin "$default_target/" \
        --adaptive_shim_bin "$adaptive_target/"  "shim gen"
    local i; for i in "$@"; do

        [ -f "$source/$i" ] || {
            x_cmd_pkg:error "Not found: [$source/$i]"
            return 1
        }

        if [ "$i" != "${i%.exe*}" ] && [ "$code" = "bat" ]; then
            target="${i%.exe*}.bat"
        elif [ "$i" != "${i%.exe*}" ] && [ "$code" = "sh" ]; then
            target="${i%".exe"*}"
        elif [ "$i" = "${i%.exe*}" ] && [ "$code" = "bat" ]; then
            target="$i.bat"
        else
            target="$i"
        fi
        target="${target##*/}"

        case "$code" in
            bat) eval set -- ___x_cmd_shim__gen_batcode_local "$___X_CMD_PKG_SHIM_BIN_OPTS"  -- "$source/$i" ;;

            sh)  eval set -- ___x_cmd_shim__gen_shcode_local  "$___X_CMD_PKG_SHIM_BIN_OPTS"  -- "$source/$i" ;;
        esac
        local IFS=" "; x_cmd_pkg:debug "cmd -> $*"; "$@" > "$default_target/$target" || return
        command chmod +x  "$source/$i" "$default_target/$target"

        if [ "$mode" = "adaptive" ]; then
            case "$code" in
                bat) eval set -- ___x_cmd_shim__gen_batcode_varset "$___X_CMD_PKG_SHIM_BIN_OPTS"  -- "$source/$i" ;;

                sh)  eval set -- ___x_cmd_shim__gen_shcode_varset  "$___X_CMD_PKG_SHIM_BIN_OPTS"  -- "$source/$i" ;;
            esac
            IFS=" "; x_cmd_pkg:debug "cmd -> $*"; "$@" > "$adaptive_target/$target" || return
            command chmod +x "$adaptive_target/$target"
        fi
    done
}

___x_cmd_pkg_shim_gen_app(){
    ___x_cmd_pkg_shim_gen \
        --mode app --code sh            \
        --bin_dir bin                   \
        --bin_file  "$@"                || return
    [ "$___X_CMD_PKG___META_OS" != "win" ] || {
        ___x_cmd_pkg_shim_gen \
        --mode app --code bat           \
        --bin_dir bin                   \
        --bin_file "$@"                 || return
    }
}
