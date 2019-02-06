#!/bin/bash

source ${BASH_UTILS_LOCATION}/logError.sh

#
# Prints a number of lines from a file starting at a specified line.
#
# @param $1 fileName
# @param $2 startingLine
# @param $3 lineCount – how many lines will be printed. Defaults to 1.
#
function printCertainLinesFromFile {
  if [ -z "${1}" ]; then
    logError "The file name must be provided as the first parameter to printCertainLinesFromFile"
    return 1
  fi
  fileName=${1}

  if [ -z "${2}" ]; then
    logError "The starting line must be provided as the first parameter to printCertainLinesFromFile"
    return 1
  fi
  startingLine=${2}

  if [ -z "${3}" ]; then
    lineCount=1
  else
    lineCount=${3}
  fi

  tail -n+${startingLine} ${fileName} | head -${lineCount}
}