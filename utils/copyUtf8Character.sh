#!/bin/bash

copyUtf8Character() {
  if [ -z "${1}" ]; then
    logError "Provide a character name to search for as the first argument."
    return 1
  fi
  local fileName=${BASH_UTILS_LOCATION}/utils/utf8CharacterList.txt
  if [ ! -f "${fileName}" ]; then
    logError "Could not find expected file ${fileName}. This is unexpected."
    return 1
  fi
  local result=`grep -i ${1} ${fileName}`
  if [ -z "${result}" ]; then
    logError "Could not find character matching '${1}'."
    return 1
  fi
  local moreThanOneResult=`echo "${result}" | wc -l`
  if [ ${moreThanOneResult} -gt 1 ]; then
    logError "Found more than one result matching '${1}':\n${result}"
    return 1
  fi
  local char=`echo ${result} | perl -p -e 's/ .*//'`
  copyLineToClipboard ${char}
  logSuccess "Copied ${char} to clipboard!"
}
