#!/bin/bash

#
# Toggle synaptic touchpad on/off
#
function toggleTouchpad {
  id=$(xinput list | grep -i ${TOUCHPAD_REGEX} | perl -p -e "s/.*id=([0-9]+).*/\$1/")

  if [ -z "$id" ]; then
	  logError "No device found matching expression ${TOUCHPAD_REGEX}. Check \`xinput list\` and adjust TOUCHPAD_REGEX in .env file."
	  return 1
  fi

  enabled=$(xinput --list-props $id | grep -iE "Device Enabled.*:.*1")

  if [[ -n $enabled ]]; then
    xinput --disable $id && \
    logSuccess Touchpad is disabled now.
  else
    xinput --enable $id && \
    logSuccess Touchpad is enabled now.
  fi
}
