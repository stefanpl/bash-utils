#!/bin/bash

###
# This function will move the mouse cursor to the center of the currently focused window
###

source ${BASH_UTILS_LOCATION}/logError.sh
source ${BASH_UTILS_LOCATION}/logInfo.sh

function moveMouseToFocusedWindow() {
    requiredCommand=xdotool
    XDT=`command -v ${requiredCommand}`
    if [ -z "$XDT" ]; then
      logError "${requiredCommand} could not be found. Must be installed for moveMouseToFocusedWindow to work."
      exit
    fi
    WINDOW=`$XDT getwindowfocus`
    
    # this brings in variables WIDTH and HEIGHT
    eval `xdotool getwindowgeometry --shell $WINDOW`
    
    TX=`expr $WIDTH / 2`
    TY=`expr $HEIGHT / 2`
    
    $XDT mousemove -window $WINDOW $TX $TY
}

