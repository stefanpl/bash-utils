#!/bin/bash

#
# Opens in vscode one of those (sorted by priority):
# - a folder/file supplied via the first argument
# - a .code-workspace file in the current folder
# - the current folder
#
function openInVsCode {
  if [ ! -z "${1}" ]; then
    code ${1}
    return 0
  fi
  workspace=`find . -maxdepth 1 -mindepth 1 -name "*.code-workspace"`
  if [ ! -z "${workspace}" ]; then
    code ${workspace}
  else
    code .
  fi
}