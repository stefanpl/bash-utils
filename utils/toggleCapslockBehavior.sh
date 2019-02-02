#!/bin/bash

source ${BASH_UTILS_LOCATION}/logError.sh
source ${BASH_UTILS_LOCATION}/logSuccess.sh

# Toggle capslock behavior between default (capslock) and "swap with escape key"

function toggleCapslockBehavior() {

  function check_if_setxkbmap_is_available() {
    setxkbmap -version > /dev/null 2>&1 || setxkbmap -help > /dev/null 2>&1 || (logError \
    "setxkbmap does not seem to be installed, but is required for this script. Aborting." ; return 1;)
  }

  function swap_behavior() {
    if setxkbmap -print | grep "capslock(swapescape)" > /dev/null 2>&1; then
      setxkbmap -option && \
      logSuccess "Capslock/escape reverted to default behavior."
    else
      setxkbmap -option "caps:swapescape" && \
      logSuccess "Capslock/escape are swapped now!"
    fi
  }

  check_if_setxkbmap_is_available && swap_behavior
}
