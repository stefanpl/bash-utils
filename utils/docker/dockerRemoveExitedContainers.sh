#!/bin/bash

###
#
# Remove all docker containers which have a status of 'exited'.
#
###
dockerRemoveExitedContainers() {

	docker rm `docker ps --all --quiet --filter "status=exited"`

}
