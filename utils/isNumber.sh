#!/bin/bash

###
# Check if the proviced param is a number
###
function isNumber() {
  if [ -z "${1}" ]; then
    logError "isNumber needs a param to check …"
  fi
  echo ${1} | grep -E "^[0-9]+$" > /dev/null
  return $?
}
