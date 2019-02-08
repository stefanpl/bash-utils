#!/bin/bash

source ${BASH_UTILS_LOCATION}/logError.sh
source ${BASH_UTILS_LOCATION}/colors.sh

#
# Logs a formatted success message to stdout.
#
function logSuccess {
  if [ -z "${1}" ]; then
    logError "A message must be provided to logSuccess."
    return 1
  fi
  printf "${GREEN} ✓ YAY: ${*}\n${NORMAL}" 1>&2;
}