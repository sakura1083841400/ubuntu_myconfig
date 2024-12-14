# shellcheck shell=dash

# check the --version

if ! kotlin -version >&2 ;then
    pkg:error "fail to get version"
    return 1
fi
