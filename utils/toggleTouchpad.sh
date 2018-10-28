#!/bin/bash

#!/bin/bash

#
# Toggle synaptic touchpad on/off
#
function toggleTouchpad {
  id=$(xinput list | grep -i touchpad | perl -p -e "s/.*id=([0-9]+).*/\$1/")

  enabled=$(xinput --list-props $id | grep -iE "Device Enabled.*:.*1")

  if [[ -n $enabled ]]; then
    xinput --disable $id && \
    logSuccess Touchpad is disabled now.
  else
    xinput --enable $id && \
    logSuccess Touchpad is enabled now.
  fi
}