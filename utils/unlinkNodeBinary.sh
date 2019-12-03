#!/bin/bash

source ${BASH_UTILS_LOCATION}/utils/logError.sh
source ${BASH_UTILS_LOCATION}/utils/logInfo.sh

#
# If /bin/node is a symbolic link, remove it.
#
function unlinkNodeBinary {
  nodeBinary=/bin/node

  if [ -h "${nodeBinary}" ]; then
    sudo rm ${nodeBinary}
  else 
    if [ -f "${nodeBinary}" ]; then
      logError "${nodeBinary} is a file, but not a symbolic link. Not removing."
      return 1
    fi
  fi
}