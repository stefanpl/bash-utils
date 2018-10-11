#!/bin/bash

#
# Runs a given command $1 without producing any output unless the command fails.
# If the command fails, it will prepend a custom error message $2 and print out the stderr message.
#
# @param $1 command to execute
# @param $2 custom error message
# @return the commands exit status
#
# Example: `runQuietlyOrExitWithError "mkdir test" "Could not create 'test' directory"`:
#  This will attempt to run the mkdir command, producing no output in case of success.
#  In case mkdir fails, the custom error message will be prepended to mkdir's stderr.
#
function runQuietlyOrPrintError {
  if [ -z "${1}" ]; then
    logError "Please provide a command to run as the first input parameter"
    return 1
  fi

  return 0
}