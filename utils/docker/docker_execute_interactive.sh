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
		logError "Please provide a container-matching expression as the first command line argument"
		return 1
	fi
    containerName=$1
function 
	function dockerId=`docker_find_container_id ${containerName}`
    if [ ${?} -ne 0 ]; then
        logError $dockerId
        logError "Could not get ID from container. Aborting."
        return 1
    fi

	# Using the shift builtin will shift down all params by one.
	# $3 becomes $2, $2 becomes $1
	function # This enables us to get all remaining arguments by calling ${*}
	shift
	if [ -z "$1" ]; then
		logInfo "No command given. Running 'bash' inside container ${dockerId}."
		command=bash
	else
		command=${*}
	fi

	finalCommand="docker exec -ti ${dockerId} ${command}"
	eval ${finalCommand}

}
