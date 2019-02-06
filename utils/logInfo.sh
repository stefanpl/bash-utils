#!/bin/bash

source ${BASH_UTILS_LOCATION}/logError.sh

#
# Logs a formatted info message to stdout.
#
function logInfo {
  if [ -z "${1}" ]; then
    logError "A message must be provided to logInfo."
    return 1
  fi
  printf "${YELLOW} 🛈 INFO: ${*}\n${NORMAL}"
}