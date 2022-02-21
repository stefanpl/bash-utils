#!/bin/bash

###
# Forward a local port to a port on a ssh server
# @param1: ssh server
# @param2: local port to forward
# [@param3]: remote port to point to. Defaults to the local port.
###
forwardLocalPort() {
  if ! command -v autossh >/dev/null; then
    logInfo "autossh not installed. Defaulting to blank ssh, but installing autossh is very much recommended."
    local baseCommand="ssh"
  else
    local baseCommand="autossh -M 0"
  fi

  if [ ${#} -eq 2 ]; then
    local remotePort=${2}
  elif [ ${#} -eq 3 ]; then
    local remotePort=${3}
  else
    logError "Usage: forwardLocalPort sshServer localPort [remotePort]"
    return 1
  fi
  local localPort=${2}
  local sshServer=${1}

  logInfo "Trying to forward local port ${localPort} to ${sshServer}:${remotePort}"
  eval "${baseCommand} -fNnT -o \"ServerAliveInterval 10\" -o \"ServerAliveCountMax 2\" -L ${localPort}:localhost:${remotePort} ${sshServer}"
}
