#!/bin/bash

#
# Logs a formatted error to stderr.
#
function logError {
  if [ -z "${1}" ]; then
    logError "An error message must be provided to logError."
    return 1
  fi
  printf "${RED} ⛔ ERROR: ${*}\n${NORMAL}" 1>&2;
}