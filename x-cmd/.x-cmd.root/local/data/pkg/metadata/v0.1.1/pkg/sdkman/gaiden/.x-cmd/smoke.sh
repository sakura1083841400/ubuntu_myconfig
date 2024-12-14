# shellcheck shell=dash

# check the --version
# Gaiden-1.3 与 java v18.0.2-sem 不兼容

if ! gaiden --version 2>&1;then
    pkg:error "fail to get version"
    return 1
fi
