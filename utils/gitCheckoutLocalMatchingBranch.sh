#!/bin/bash

source ${BASH_UTILS_LOCATION}/utils/logError.sh
source ${BASH_UTILS_LOCATION}/utils/colors.sh

#
# Checks out a local branch matching a given expression.
#
function gitCheckoutLocalMatchingBranch {
  if [ -z "${1}" ]; then
    logError "An expression matching a branch must be provided."
    return 1
  fi
  matchingBranch=`git branch | grep -i "${1}"`
  if [ -z "${matchingBranch}" ]; then
    logError "Could not find a branch matching '${1}'"
    return 1
  fi
  numberOfMatches=`echo ${matchingBranch} | wc -l`
  if [ "$numberOfMatches" -gt 1 ]; then
    logError "Found multiple local branches matching '${1}':"
    echo ${matchingBranch}
    return 1
  fi
  # xargs is used to trim the branch name
  git checkout `echo ${matchingBranch} | xargs echo`
}
