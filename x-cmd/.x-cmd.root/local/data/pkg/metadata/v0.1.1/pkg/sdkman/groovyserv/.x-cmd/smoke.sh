# shellcheck shell=dash

# check the --version

if ! groovyserver --help ;then
    pkg:error "fail to get version"
    return 1
fi