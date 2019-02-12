#!/bin/bash
set -e

scriptDirectory=$( dirname ${BASH_SOURCE[0]} )
export ADDITIONAL_DOCKER_RUN_FLAGS="--detach"
source ${scriptDirectory}/utils.sh

runCommandOnNodeContainer npm run test-debug