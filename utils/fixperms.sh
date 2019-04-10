#!/bin/bash

source ${BASH_UTILS_LOCATION}/logError.sh
source ${BASH_UTILS_LOCATION}/logInfo.sh

#
# Sets files to 664 and folders to 775 inside a given directory
#
function fixperms {
  if [ -z "${1}" ]; then
    logError "Provide a folder as the first command argument!"
    return 1
  fi
  folder=${1}
  if [ ! -d "$1" ]; then
    logError "The given argument '${1}' does not appear to be a folder."
  fi
  sudo find ${1} -type f -exec chmod 664 {} \;
  sudo find ${1} -type d -exec chmod 775 {} \;
}

