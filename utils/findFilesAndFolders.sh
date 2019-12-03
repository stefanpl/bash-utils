#!/bin/bash

source ${BASH_UTILS_LOCATION}/utils/logError.sh
source ${BASH_UTILS_LOCATION}/utils/logInfo.sh

#
# Finds files and folders containing the provided search term
#
function findFilesAndFolders {
  if [ -z "${1}" ]; then
    logError "What should we search for? Provide a search term!"
    return 1
  fi
  searchTerm=${*}
  if [ "$EUID" -ne 0  ]; then
    logInfo "Searching without root privileges. Some results may not be found."
  fi
  find . -iname "*$1*" 2>/dev/null
}

