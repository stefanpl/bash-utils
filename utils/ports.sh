#!/bin/bash

###
# List active TCP ports on the system
###
ports() {
  if [ ! -z "${IS_MACOS}" ]; then
    local baseCommand="lsof -iTCP -sTCP:LISTEN -n -P"
  else
    local baseCommand="netstat -tulpn"
  fi
  eval "sudo ${baseCommand}"
}
