# shellcheck    shell=dash
x log init x_cmd_pkg
xrc shim

___x_cmd_pkg_groovy_populate(){
    local source="$___X_CMD_PKG___META_TGT/bin"
    local target="$___X_CMD_PKG___META_TGT/shim_bin"
    x mkdirp "$target"

    local op="$1"; shift
    x_cmd_pkg:info --source "$source" --shim_bin "$target" "shim gen ${op} code"
    local x_treename=; ___x_cmd_pkg_treename_ java v18.0.2-sem "$___X_CMD_PKG___META_OS/$___X_CMD_PKG___META_ARCH" || return
    local i; for i in "$@"; do
        [ -f "$source/$i" ] || return
        x_cmd_pkg:info "Generating shim_bin/$i"
        case "$op" in
            bat)
                ___x_cmd_shim__gen_batcode_varset "JAVA_HOME=$___X_CMD_PKG_ROOT_SPHERE/X/$x_treename/java/v18.0.2-sem"  -- "$source/$i" > "$target/$i" || return ;;
            sh)
                ___x_cmd_shim__gen_shcode_varset "JAVA_HOME=\${JAVA_HOME:-$___X_CMD_PKG_ROOT_SPHERE/X/$x_treename/java/v18.0.2-sem}"  -- "$source/$i" > "$target/$i" || return ;;
        esac
        command chmod +x "$target/$i" "$source/$i"
    done
}

if [ "$___X_CMD_PKG___META_OS" = "win" ]; then
    ___x_cmd_pkg_groovy_populate bat groovy.bat || return
fi

___x_cmd_pkg_groovy_populate sh groovy || return


