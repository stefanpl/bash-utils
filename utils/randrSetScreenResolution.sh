#!/bin/bash

function randrSetScreenResolution() {
  if [ -z "${1}" ]; then
    logError "Provide a screen identifier (from xrandr) to randrSetScreenResolution" 
    return 1
  fi
  if [ -z "${2}" ]; then
    logError "Provide a width to randrSetScreenResolution" 
    return 1
  fi
  if [ -z "${3}" ]; then
    screenHeight=$(( ${2} / 16 * 9 ))
  else
    screenHeight=${3}
  fi
  echo $screenHeight
  modeline=$(cvt ${2} ${screenHeight} 60 \
    | perl -p -e 's/Modeline //' \
    | perl -p -e 's/^#.*$\\n//')
  modename=$( echo $modeline | egrep -o '"[0-9x_.]+"' )
  echo ${modeline}
  echo ${modename}
  xrandr --newmode ${modeline}
  xrandr --addmode ${1} ${modename}
  xrandr --output ${1} --mode ${modename}
}
