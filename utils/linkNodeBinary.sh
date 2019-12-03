#!/bin/bash

source ${BASH_UTILS_LOCATION}/utils/logError.sh
source ${BASH_UTILS_LOCATION}/utils/logInfo.sh

#
# Creates a link from the default nvm node version to /bin/node
#
function linkNodeBinary {
  binaryPath=/bin/node
  unlinkNodeBinary || return 1
  loadNvm || return 1
  nodePath=`which node`
  sudo ln -s ${nodePath} ${binaryPath}
  logInfo "Created link from ${nodePath} to ${binaryPath}"
}