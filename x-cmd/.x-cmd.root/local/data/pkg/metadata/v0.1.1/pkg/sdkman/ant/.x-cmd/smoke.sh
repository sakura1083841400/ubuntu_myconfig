# shellcheck shell=dash

# check the --version

if ! ant -version ;then
    pkg:error "fail to get version"
    return 1
fi
