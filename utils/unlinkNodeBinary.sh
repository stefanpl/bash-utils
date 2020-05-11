#!/bin/bash

#
# If /bin/node is a symbolic link, remove it.
#
function unlinkNodeBinary {
  nodeBinary=/bin/node
  if [ "${1}" = "--silent" ]; then
    silent=true
  fi

  if [ -h "${nodeBinary}" ]; then
    sudo rm ${nodeBinary}
    if [ -z "${silent}" ]; then
      logSuccess "Removed symbolic link ${nodeBinary}"
    fi
  else 
    if [ -f "${nodeBinary}" ]; then
      logError "${nodeBinary} is a file, but not a symbolic link. Not removing."
      return 1
    else
      if [ -z "${silent}" ]; then
        logInfo "${nodeBinary} not found."
      fi
    fi
  fi
}