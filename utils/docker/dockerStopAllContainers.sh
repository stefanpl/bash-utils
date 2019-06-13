#!/bin/bash

##
# Stop all docker containers
##

function dockerStopAllContainers() {
  docker stop $(docker ps -a -q)  
}