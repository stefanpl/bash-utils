#!/bin/bash

source ${BASH_UTILS_LOCATION}/logError.sh

###
#
# Extract the ID from a docker container matching a given string
# @param $1 – the string which matches a container
#
###
function docker_find_container_id() {
    if [ -z "$1" ]; then
        logError "Please provide a matching expression as the first command line argument"
        return 1
    fi

    match=`docker container ls | grep -i ${1}`
    numberOfMatchedLines=`echo ${match} | grep -E -c "^."`
    if [[ $numberOfMatchedLines == "0" ]]; then
        logError "No result found for expression '${1}'"
        return 1
    fi;
    if [[ $numberOfMatchedLines -gt "1" ]]; then
        logError "Found ${numberOfMatchedLines} matches for expression '${1}':"
        logError $match
        logError "This command expects only one result"
        return 1
    fi;

    # We have exactly one result. Extract it!
    id=`echo ${match} | perl -p -e "s/(^[0-9a-f]*).*/\\$1/"`
    echo $id
    return 0

}