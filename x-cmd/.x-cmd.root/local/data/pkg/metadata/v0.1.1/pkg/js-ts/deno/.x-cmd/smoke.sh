# shellcheck shell=dash

# check the --version
if ! deno --version >&2 ;then
    pkg:error "fail to get version"
    return 1
fi