#!/bin/bash

###
# @param1 json file location
# @param2 key in the json file
###
function getValueFromJsonFile() {
  if [ -z "${1}" ] || [ ! -f "${1}" ]; then
    logError "Param 1 must be the path to a json file"
    return 1
  fi
  if [ -z "${2}" ]; then
    logError "Param 2 must be a key in the json file"
    return 1
  fi
  jsonFile="${1}"
  key="${2}"
  lineExpression="${key}\" *:"
  lines=`egrep "${lineExpression}" "${jsonFile}"`
  lineCount=`echo ${lines} | wc -l`
  if [ "${lineCount}" -gt 1 ]; then
    logError "Found ${lineCount} keys matching key '${key}'. This is currently not supported."
    return 1
  fi
  if [ -z "${lines}" ]; then
    logError "Key '${key}' not found in ${jsonFile}."
    return 1
  fi
  valueExpression="s/[^:]*: *\"([^\"]+)\".*/\$1/"
  value=`echo ${lines} | perl -p -e ${valueExpression}`
  echo ${value}
}
