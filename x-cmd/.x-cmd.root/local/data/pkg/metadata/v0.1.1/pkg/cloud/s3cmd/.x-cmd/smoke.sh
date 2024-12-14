# shellcheck    shell=dash
x os name_
if [ "$___X_CMD_OS_NAME_" = "win" ]; then
  pkg:error "Stuck, there may be a pop-up window"
  return 1
else
  pkg:warn "s3cmd --version"
  if ! s3cmd --version 2>&1;then
    pkg:error "fail to get version"
    return 1
  fi
fi
