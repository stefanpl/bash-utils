#!/bin/bash

source ${BASH_UTILS_LOCATION}/utils/logError.sh
source ${BASH_UTILS_LOCATION}/utils/logSuccess.sh
source ${BASH_UTILS_LOCATION}/utils/logInfo.sh

# Searches for variables in a file declared as:
# variable=value
# and exports them so they can be used by child scripts.

function exportVariablesFromFile() {
  if [ -z "${1}" ]; then
    logError "Provide a file containing the variables as the first argument."
    return 1
  fi
  if [ ! -f "${1}" ]; then
    logError "Argument '${1}' is not a valid file."
    return 1
  fi

  variablesInFile=`grep -E "^[-_a-z0-9A-Z]+=" ${1}`
  while read -r line; do
    variableName=`echo $line | perl -p -e "s/=.*$//"`
    variableValue=`echo $line | perl -p -e "s/^.*=//"`
    export ${variableName}="${variableValue}"
  done <<< "$variablesInFile"

}
