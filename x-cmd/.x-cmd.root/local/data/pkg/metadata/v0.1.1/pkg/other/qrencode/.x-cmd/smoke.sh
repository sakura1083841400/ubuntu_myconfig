# shellcheck shell=dash
x os name_
if [ "$___X_CMD_OS_NAME_" = "darwin" ];then
    return 1
else
    if ! qrencode --version 2>&1;then
        pkg:error "fail to get version"
        return 1
    fi
fi