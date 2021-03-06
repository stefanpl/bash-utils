#!/bin/bash

source ${BASH_UTILS_LOCATION}/utils/logError.sh
source ${BASH_UTILS_LOCATION}/utils/logSuccess.sh

###
#
# Extract the IP from a docker container matching a given string
# @param $1 – the string which matches a container
#
###
function docker_find_container_ip() {

	if [ -z "$1" ]; then
		logError "Please provide a container-matching expression as the first command line argument"
		return 1
	fi

	dockerId=`docker_find_container_id ${1}`

	logSuccess "IP Addresses for docker container ${dockerId}:"
	docker inspect ${dockerId} | grep -iE "ip.*address.*([0-9]{1,3})+" | perl -p -e "s/^[^:]+: \"([.0-9]+).*$/\$1/g" | uniq
}
