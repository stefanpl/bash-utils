#!/bin/bash

source ${BASH_UTILS_LOCATION}/colors.sh

#
# Logs a formatted error to stderr.
#
function logError {
  if [ -z "${1}" ]; then
    logError "An error message must be provided to logError."
    return 1
  fi
  if [ "${CLEAN_OUTPUT}" = "true" ]; then
    echo ${*} 1>&2
  else
    printf "${RED} ⛔ ERROR: ${*}\n${NORMAL}" 1>&2
  fi
}