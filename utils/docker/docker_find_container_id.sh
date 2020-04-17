#!/bin/bash

source ${BASH_UTILS_LOCATION}/utils/logError.sh

###
#
# Extract the ID from a docker container matching a given string
# @param $1 if set to '--all', matching is performed against all containers
# @param $* – the string which matches a container
#
###
function docker_find_container_id() {
    if [ "${1}" = "--all" ]; then
        allArgument="--all"
        shift
    else
        allArgument=""
    fi
    
    if [ -z "$1" ]; then
        logError "Please provide a matching expression as the first command line argument"
        return 1
    fi

    match=`docker container ls ${allArgument} | grep -i ${1}`
    numberOfMatchedLines=`echo ${match} | grep -E -c "^."`
    if [[ $numberOfMatchedLines == "0" ]]; then
        logError "No container found for given expression '${1}'"
        return 1
    fi;
    if [[ $numberOfMatchedLines -gt "1" ]]; then
        logError "Found ${numberOfMatchedLines} containers for expression '${1}':"
        logError $match
        logError "This command expects only one result."
        return 1
    fi;

    # We have exactly one result. Extract it!
    id=`echo ${match} | perl -p -e "s/(^[0-9a-f]*).*/\\$1/"`
    echo $id
    return 0

}