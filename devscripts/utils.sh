#!/bin/bash
set -e
export SCRIPT_DIRECTORY=$( dirname ${BASH_SOURCE[0]} )
BASH_UTILS_LOCATION=${SCRIPT_DIRECTORY}/cloned-bash-utils/utils

if [ -z "$BASH_UTILS_LOCATION" ] || [ ! -d "$BASH_UTILS_LOCATION" ]; then
  # We want to utilize the bash-utils while developing the bash-utils. Such meta.
  # To avoid using the dev environment's utils (which could be broken) we clone a fresh version.
  # Unfortunately, npm does not permit adding a repo as a dependency of itself, so we need to use git clone.
  git --version > /dev/null
  echo "Cloning clean version of bash-utils, just one second porfa …"
  git clone --quiet https://github.com/stefanpl/bash-utils ${SCRIPT_DIRECTORY}/cloned-bash-utils
fi

source ${BASH_UTILS_LOCATION}/logError.sh
source ${BASH_UTILS_LOCATION}/logSuccess.sh
source ${BASH_UTILS_LOCATION}/logInfo.sh

function runCommandOnNodeContainer() {
  if [ -z "${1}" ]; then
    logInfo "No command given to run. Opening an interactive bash shell."
    commandToRun="/bin/bash"
  else
    commandToRun="${*}"
  fi

  if [ -z "$LOCAL_DEBUG_PORT" ]; then
    localDebugPort=9229
  else
    localDebugPort=${LOCAL_DEBUG_PORT}
  fi

  absolutePathToCode=`cd ${SCRIPT_DIRECTORY}/../ && pwd`
  workdir=/home/node/app

  docker run --tty --interactive --user node --mount type=bind,src=${absolutePathToCode},dst=${workdir} \
    --workdir ${workdir} --publish 127.0.0.1:${localDebugPort}:9229 ${ADDITIONAL_DOCKER_RUN_FLAGS} \
    "node:10.15-jessie-slim" /bin/bash -c "${commandToRun}"
}
