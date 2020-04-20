#!/bin/bash

###
# Generate lorem hipsum filler text.
# @param1 number of sentences
###
function getHipsumText() {
  if [ -z "${1}" ]; then
    logError "Param 1 must provide a number of sentences."
    return 1
  fi
  if ! isNumber ${1}; then
    logError "Param 1 must be a number."
    return 1
  fi
  curl -s "https://hipsum.co/api/?type=hipster-latin&sentences=${1}" \
    | jq '.[0]' | perl -p -e 's/"//g'
}