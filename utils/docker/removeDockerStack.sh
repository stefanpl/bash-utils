#!/bin/bash

source ${BASH_UTILS_LOCATION}/utils/logError.sh
source ${BASH_UTILS_LOCATION}/utils/logInfo.sh

#
# `docker stack rm` does not wait for completion.
# This will cause a subsequent start command to fail.
# Wait until services and networks are cleared.
# 
# Taken from https://github.com/moby/moby/issues/30942
# 
function removeDockerStack() {
  if [ -z "${1}" ]; then
    logError "A stack name must be provided to removeDockerStack."
    return 1
  fi

  docker stack rm ${1}
  logInfo "Waiting for services and networks to be cleaned up …"
  
  until [ -z "$(docker service ls --filter label=com.docker.stack.namespace=${STACK_NAME} -q)" ]; do
    sleep 1;
  done
  until [ -z "$(docker network ls --filter label=com.docker.stack.namespace=${STACK_NAME} -q)" ]; do
    sleep 1;
  done
  sleep 3;
}