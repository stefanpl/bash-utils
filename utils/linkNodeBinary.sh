#!/bin/bash

#
# Creates a link from the default nvm node version to /bin/node
#
function linkNodeBinary {
  binaryPath=/bin/node
  unlinkNodeBinary --silent || return 1
  loadNvm || return 1
  nodePath=`w node`
  sudo ln -s ${nodePath} ${binaryPath}
  logSuccess "Created link from ${nodePath} to ${binaryPath}"
}