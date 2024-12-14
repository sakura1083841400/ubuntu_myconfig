# shellcheck    shell=dash
. "$___X_CMD_PKG_METADATA_PATH/.x-cmd/gen_shim_file.sh"


___x_cmd_pkg_skeletal_populate(){
    local x_treename=; ___x_cmd_pkg_treename_ java v18.0.2-sem "$___X_CMD_PKG___META_OS/$___X_CMD_PKG___META_ARCH"
    local java_env=; java_env="JAVA_HOME=$___X_CMD_PKG_ROOT_SPHERE/X/$x_treename/java/v18.0.2-sem"

    ! [ "$___X_CMD_PKG___META_OS" = "win" ] || {
        ___x_cmd_pkg_shim_gen --mode adaptive --code bat --var "${java_env}" --bin_dir bin --bin_file skeletal.bat || return
    }
    ___x_cmd_pkg_shim_gen --mode adaptive --code sh  --var "${java_env}" --bin_dir bin --bin_file skeletal || return
}

___x_cmd_pkg_skeletal_populate
