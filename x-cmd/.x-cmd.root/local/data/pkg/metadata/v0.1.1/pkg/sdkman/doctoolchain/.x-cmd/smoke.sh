# shellcheck shell=dash

# check the --version

if ! doctoolchain . --help ;then
    pkg:error "fail to get version"
    return 1
fi
