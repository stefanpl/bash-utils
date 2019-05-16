#!/bin/bash

###
# Remove unneeded docker components to reclaim system space
###

function dockerCleanup() {
  danglingVolumes=`docker volume ls -qf dangling=true`
  if [ ! -z "$lastUpdated" ]; then
    docker volume rm ${danglingVolumes}
  fi
  docker system prune -a -f
}
