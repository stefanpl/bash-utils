#!/bin/bash

source ${BASH_UTILS_LOCATION}/utils/logError.sh
source ${BASH_UTILS_LOCATION}/utils/colors.sh

#
# Logs a formatted success message to stdout.
#
logSuccess() {
  if [ -z "${1}" ]; then
    logError "A message must be provided to logSuccess."
    return 1
  fi
  if [ "${CLEAN_OUTPUT}" = "true" ]; then
    echo ${*}
    return
  fi
  if [ "${CLEAN_OUTPUT}" = "noprefix" ]; then
    printf "${GREEN}${*}\n${NORMAL}"
    return
  fi
  printf "${GREEN} ✓ YAY: ${*}\n${NORMAL}"
}