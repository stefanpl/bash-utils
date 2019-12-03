#!/bin/bash

source ${BASH_UTILS_LOCATION}/utils/logError.sh
source ${BASH_UTILS_LOCATION}/utils/logSuccess.sh
source ${BASH_UTILS_LOCATION}/utils/logInfo.sh

###
#
# Creates a data directory to be mounted for an empty rethink db docker container.
# This is needed because there is a bug which prevents rethink from creating the necessary files itself.
# Currently, metadata and log_file files are created alongside a tmp directory.
#
# @param $1 – the directory which will be initialized as the data directory.
#
###
function initializeRethinkDataDirectory() {
  if [ -z "${1}" ]; then
    logError "Provide a directory as the first parameter."
    return 1
  fi
  if [ ! -d "${1}" ]; then
    logError "The given argument ${1} does not appear to be a directory."
  fi

  function cleanup() {
    if [ ! -z ${tmpDirForRethinkData} ]; then
      rm -rf ${tmpDirForRethinkData}
    fi
  }
  trap cleanup EXIT RETURN

  # Cound the files in the folder. In case there are any files (not including .gitignore), abort.
  numberOfFiles=`ls | wc -l`

  if [ ${numberOfFiles} -gt "0" ]; then
    logInfo "Found files in directory ${datadir}. Assuming database is initialized."
    return 0
  fi

  # Check if git is available
  git --version > /dev/null 
  if [ $? -ne 0 ]; then
    logError "Cannot proceed without git installed."
    return 1
  fi

  tmpDirForRethinkData=`mktemp -d`
  git clone --quiet https://github.com/stefanpl/empty-rethinkdb-data-directory ${tmpDirForRethinkData} > /dev/null || return 1
  mv ${tmpDirForRethinkData}/rethinkdb-data/* ${datadir} || return 1
  logSuccess "Rethinkdb meta data successfully copied."
}
