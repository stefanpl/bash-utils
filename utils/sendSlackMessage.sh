#!/bin/bash

###
# This function will send a message to ${SLACK_HOOK}
###

source ${BASH_UTILS_LOCATION}/utils/logError.sh

function sendSlackMessage() {
    if [ -z "$1" ]; then
      logError "A message must be provided to sendSlackMessage"
      exit
    fi
    username=`id -un`@`uname -n`
    curl --data "{\"text\": \"${*}\", \"username\": \"${username}\"}" ${SLACK_HOOK}
}

