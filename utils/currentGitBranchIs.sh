#!/bin/bash
set -e

###
# Checks if the git branch in the pwd is equivalent to the first argument
# @param1: string to compare current git branch to
###
function currentBranchIs() {
    if [ -z "${1}" ]; then
      logError "Param 1 passed to currentBranchIs must not be empty!"
      exit 1
    fi
    branchName=$(git branch | grep '*' | perl -p -e 's/\* //')
    [[ "${branchName}" == "${1}" ]]
    return
}