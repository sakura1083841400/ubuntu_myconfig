# shellcheck shell=dash

output=$(visualvm --help)

if [ -n "$output" ];then
    return 0
else
    return 1
fi
