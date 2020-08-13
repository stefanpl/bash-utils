#!/bin/bash

#
# Executes a 'git push', checks fot git's auto-generated --set-upstream message,
#  and applies the command provided.
#
function gitPushNewBranch() {
  expectedOutput="git push --set-upstream"
  output=`git push 2>&1`
  match=`echo "${output}" | grep "${expectedOutput}" | perl -p -e "s/^.*git/git/"`
  if [ -z "${match}" ]; then
    logError "Git output did not contain command suggestion. Output was:\n${output}"
    return 1
  else
    logInfo "Running '${match}':"
    eval "${match}"
  fi
}