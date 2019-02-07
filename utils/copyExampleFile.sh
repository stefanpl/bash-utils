#!/bin/bash

source ${BASH_UTILS_LOCATION}/logError.sh
source ${BASH_UTILS_LOCATION}/logSuccess.sh
source ${BASH_UTILS_LOCATION}/logInfo.sh

###
#
# Copies a given [whatever].example file to its [whatever] counterpart, if it does not exist already.
#
# @param $1 – the .example file to be copied
#
###
function copyExampleFile() {
  if [ -z "${1}" ]; then
    logError "Provide a .example file as the first argument."
    return 1
  fi

  exampleFile=$1
  if [ ! -f ${exampleFile} ]; then
    logError "The given file ${exampleFile} does not exist."
    return 1
  fi

  pushd `dirname ${exampleFile}` > /dev/null
  trap "popd > /dev/null" EXIT RETURN
  
  filenameWithoutExampleSuffix=`basename ${exampleFile} | perl -p -e "s/\.example\$//"` 
  if [ -z "$filenameWithoutExampleSuffix" ]; then
    logError "The given file ${exampleFile} does not seem to end with the suffix '.example' – this is required."
    return 1
  fi

  if [ ! -f ${filenameWithoutExampleSuffix} ]; then
    cp `basename ${exampleFile}` ${filenameWithoutExampleSuffix} && \
    logSuccess "Created a new file `dirname ${exampleFile}`/${filenameWithoutExampleSuffix} from its .example counterpart."
  else
    logInfo "File `dirname ${exampleFile}`/${filenameWithoutExampleSuffix} already exists."
  fi
}