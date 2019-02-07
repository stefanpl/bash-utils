#!/bin/bash

source ${BASH_UTILS_LOCATION}/logInfo.sh

###
#
# Remove all docker containers which have a status of 'exited'.
#
###
dockerRemoveExitedContainers() {

	logInfo "Removing exited containers …"
	docker rm `docker ps --all --quiet --filter "status=exited"`

}
