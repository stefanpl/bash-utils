#!/bin/bash
set -e

scriptDirectory=$( dirname ${BASH_SOURCE[0]} )

if [ -z "$LOCAL_DEBUG_PORT" ]; then
  localDebugPort=9229
else
  localDebugPort=${LOCAL_DEBUG_PORT}
fi
export ADDITIONAL_DOCKER_RUN_FLAGS="--detach --publish 127.0.0.1:${localDebugPort}:9229"

source ${scriptDirectory}/utils.sh

runCommandOnNodeContainer npm run test-debug