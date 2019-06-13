#!/bin/bash

#
# Get rid of the 'glib.GError: No D-BUS daemon running' error
# 
# https://askubuntu.com/questions/354967/glib-gerror-no-d-bus-daemon-running
#
function exportDbusVariables {
  eval $(dbus-launch --sh-syntax)
  export DBUS_SESSION_BUS_PID
  export DBUS_SESSION_BUS_ADDRESS
}