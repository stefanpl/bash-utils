#!/bin/bash

#
# This function tries to set the DOCKER_HOST_IP environment variable.
#
function setDockerHostIp {
    if [ -z "${DOCKER_HOST_IP}" ]; then
		logInfo "DOCKER_HOST_IP is not set. Trying to discover via 'ifconfig'."
        numberOfDockerInterfaces=`ifconfig | grep -Ei "docker[0-9]+" | wc -l`
        if [[ ${numberOfDockerInterfaces} -eq 0 ]]; then
            logError 'Could not locate docker network interface.'
            logError 'Unable to set DOCKER_HOST_IP. Services will not run properly.'
        fi
        if [[ ${numberOfDockerInterfaces} -gt 1 ]]; then
            logError 'Found multiple docker network interfaces.'
            logError 'Unable to set DOCKER_HOST_IP. Services will not run properly.'
        fi
        # We have one docker interface listet via ipconfig. Extract the IP address.
        hostIp=$(ifconfig | grep -A 1 -Ei "docker[0-9]+" | tail -n 1 | perl -p -e "s/[^:]*:([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+).*/\$1/g" > /dev/stdout)
        logSuccess "Extracted host IP ${hostIp} via ifconfig. Setting as DOCKER_HOST_IP."
        export DOCKER_HOST_IP=${hostIp}
	else
        logSuccess "DOCKER_HOST_IP already set to ${DOCKER_HOST_IP}"
    fi
}