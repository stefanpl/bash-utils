#!/bin/bash

source ${BASH_UTILS_LOCATION}/logError.sh

##
# Runs an application in the background, without putting output to the terminal
##

function openWithoutOutput() {
  if [ -z "${1}" ]; then
    logError "A file must be provided as the first parameter to openWithOutput"
    return 1
  fi
  if [ ! -f "${1}" ]; then
    logError "Could not locate the provided file ${1}"
    return 1
  fi

  xdg-open --help > /dev/null 2>&1 || (logError "xdg-open not available." ; return)

  xdg-open ${1} > /dev/null 2>&1
}