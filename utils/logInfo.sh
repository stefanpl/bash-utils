#!/bin/bash

source ${BASH_UTILS_LOCATION}/utils/logError.sh
source ${BASH_UTILS_LOCATION}/utils/colors.sh

#
# Logs a formatted info message to stdout.
#
function logInfo {
  if [ -z "${1}" ]; then
    logError "A message must be provided to logInfo."
    return 1
  fi
  if [ "${CLEAN_OUTPUT}" = "true" ]; then
    echo ${*} 1>&2
  else
    printf "${YELLOW} 🛈 INFO: ${*}\n${NORMAL}"
  fi
}