# shellcheck shell=dash

if ! groovy -v >&2;then
    pkg:error "fail to get version"
    return 1
fi
