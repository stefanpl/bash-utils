#!/bin/bash

playSoundFile() {
  local expectedPath=${HOME}/music/latest-shit/
  if [ ! -d "${expectedPath}" ]; then
    logError "${expectedPath} does not exists."
    return 1
  fi
  if [ -z "${1}" ]; then
    CLEAN_OUTPUT=noprefix logSuccess "Available sounds:"
    find ${expectedPath} -type f -exec basename {} \;
    return 1
  fi
  local result=`find ${expectedPath} -type f -name "*${1}*"`
  if [ -z "${result}" ]; then
    logError "Could not find sound matching '${1}'."
    return 1
  fi
  local moreThanOneResult=`echo "${result}" | wc -l`
  if [ ${moreThanOneResult} -gt 1 ]; then
    logError "Found more than one result matching '${1}':\n${result}"
    return 1
  fi
  CLEAN_OUTPUT=noprefix logSuccess "🔊  🎵 🎵 🎵"
  aplay -q ${result}
}
