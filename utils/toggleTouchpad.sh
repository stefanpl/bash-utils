#!/bin/bash

source ${BASH_UTILS_LOCATION}/utils/logError.sh
source ${BASH_UTILS_LOCATION}/utils/logSuccess.sh

#
# Toggle synaptic touchpad on/off
#
function toggleTouchpad {
  id=$(xinput list | grep -i ${TOUCHPAD_REGEX} | perl -p -e "s/.*id=([0-9]+).*/\$1/")

  if [ -z "$id" ]; then
	  logError "No device found matching expression ${TOUCHPAD_REGEX}. Check \`xinput list\` and adjust TOUCHPAD_REGEX in .env file."
	  return 1
  fi

  if [ "${1}" = "--clean" ]; then
    export CLEAN_OUTPUT=true
  fi

  enabled=$(xinput --list-props $id | grep -iE "Device Enabled.*:.*1")

  if [[ -n $enabled ]]; then
    xinput --disable $id && \
    logSuccess touchpad OFF
  else
    xinput --enable $id && \
    logSuccess touchpad ON
  fi
  export CLEAN_OUTPUT=false
}
