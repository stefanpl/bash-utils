#!/bin/bash

#
# Opens in vscode one of those (sorted by priority):
# - a folder/file supplied via the first argument
# - a .code-workspace file in the current folder
# - the current folder
#
function openInVsCode {
  # New file:
  if [ ! -z "${1}" ] && [ ! -e "${1}" ]; then
    code ${1}
    return 0
  fi
  # Existing file:
  if [ -f "${1}" ]; then
    code ${1}
    return 0
  fi
  # Directory or no argument at all:
  if [ -d "${1}" ]; then
    folderToOpen=${1}
  else
    folderToOpen=.
  fi
  # Check for workspace file in the folder
  workspace=`find ${folderToOpen} -maxdepth 1 -mindepth 1 -name "*.code-workspace"`
  if [ ! -z "${workspace}" ]; then
    code ${workspace}
    return 0
  fi
  # Check for workspace file in a .vscode folder
  if [ -d "${folderToOpen}/.vscode" ]; then
    workspace=`find ${folderToOpen}/.vscode -maxdepth 1 -mindepth 1 -name "*.code-workspace"`
    if [ ! -z "${workspace}" ]; then
      code ${workspace}
      return 0
    fi
  fi
  code ${folderToOpen}
}