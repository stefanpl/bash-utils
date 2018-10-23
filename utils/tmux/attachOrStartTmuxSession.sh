#!/bin/bash

#
# Given a session $1, this script will attach a tmux client to the session or create it and then attach.
# This also works if tmux is already inside an active session.
#
# @param $1 the session name
#
function attachOrStartTmuxSession {
  if [ -z "${1}" ]; then
    logError "Please provide a command to run as the first input parameter"
    return 1
  fi

  sessionName=$1
  tmux has-session -t ${sessionName} || tmux new -s ${sessionName} -d 
  tmux switch-client -t ${sessionName}
  return 0
}