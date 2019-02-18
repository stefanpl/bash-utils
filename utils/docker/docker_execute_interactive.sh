#!/bin/bash

source ${BASH_UTILS_LOCATION}/logError.sh
source ${BASH_UTILS_LOCATION}/logInfo.sh

###
#
# Run an interactive bash shell inside a given container
# @param $1 – the string which matches a container
#
###
function docker_execute_interactive() {

	if [ -z "$1" ]; then
		logError "Please provide a container id as the first command line argument"
		return 1
	fi
    containerId=$1

	# Using the shift builtin will shift down all params by one:
	# $3 becomes $2, $2 becomes $1
	#
	# This enables us to get all remaining arguments 
	#  (e.g. the command to be executed) by calling ${*}
	shift

	if [ -z "$1" ]; then
		logInfo "No command given. Running 'bash' inside container ${containerId}."
		command=/bin/bash
	else
		command=${*}
	fi

	finalCommand="docker exec -ti ${containerId} ${command}"
	eval ${finalCommand}

}
