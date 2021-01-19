#!/bin/bash

source ${BASH_UTILS_LOCATION}/utils/logError.sh
source ${BASH_UTILS_LOCATION}/utils/logSuccess.sh

# Toggle capslock behavior between default (capslock) and "swap with escape key"

toggleCapslockBehavior() {

  check_if_setxkbmap_is_available() {
    setxkbmap -version > /dev/null 2>&1 || setxkbmap -help > /dev/null 2>&1 || (logError \
    "setxkbmap does not seem to be installed, but is required for this script. Aborting." ; return 1;)
  }

  isSwapped() {
    setxkbmap -print | grep "capslock(swapescape)" > /dev/null 2>&1;
    return $?
  }

  toggle_behavior() {
    if isSwapped ; then
      set_behavior "default"
    else
      set_behavior "swap"
    fi
  }

  check_for_illegal_argument() {
    if [ ! -z "${1}" ]; then
      logError "Unknown argument '${1}'. Use 'swap' or 'default', or none to toggle."
      return 1
    fi
  }

  set_behavior() {
    if [ "${1}" = "default" ]; then
      setxkbmap -option && \
      logSuccess "Capslock/escape set to default behavior."
    else
      setxkbmap -option "caps:swapescape" && \
      logSuccess "Capslock/escape are swapped now!"
    fi
  }

  check_if_setxkbmap_is_available || return


  if [ "${1}" = "swap" ] || [ "${1}" = "default" ]; then
    set_behavior $1
  else
    check_for_illegal_argument $1 || return
    toggle_behavior
  fi;
}
