# shellcheck shell=dash

# check the --version

if ! jbake -h ;then
    pkg:error "fail to get version"
    return 1
fi
