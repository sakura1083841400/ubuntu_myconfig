# shellcheck shell=dash

# check the --version

if ! hadoop version ;then
    pkg:error "fail to get version"
    return 1
fi
