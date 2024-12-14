# shellcheck shell=dash

# check the --version

karaf << EOF
logout
EOF
if ! [ $? -eq 0 ] ;then
    pkg:error "fail to get version"
    return 1
fi
