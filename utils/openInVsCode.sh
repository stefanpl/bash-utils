#!/bin/bash

#
# Opens in vscode one of those (sorted by priority):
# - a folder/file supplied via the first argument
# - a .code-workspace file in the current folder
# - the current folder
#
openInVsCode() {
  if [ -z "${VSCODE_BINARY}" ]; then
    local vscodeBinary=code
  else
    local vscodeBinary=${VSCODE_BINARY}
  fi
  # New file:
  if [ ! -z "${1}" ] && [ ! -e "${1}" ]; then
    ${vscodeBinary} ${1}
    return 0
  fi
  # Existing file:
  if [ -f "${1}" ]; then
    ${vscodeBinary} ${1}
    return 0
  fi
  # Directory or no argument at all:
  if [ -d "${1}" ]; then
    folderToOpen=${1}
  else
    folderToOpen=.
  fi
  # Check for workspace file in the folder
  workspace=$(find ${folderToOpen} -maxdepth 1 -mindepth 1 -name "*.code-workspace")
  if [ ! -z "${workspace}" ]; then
    code ${workspace}
    return 0
  fi
  # Check for workspace file in a .vscode folder
  if [ -d "${folderToOpen}/.vscode" ]; then
    workspace=$(find ${folderToOpen}/.vscode -maxdepth 1 -mindepth 1 -name "*.code-workspace" |
      awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2- | head -n 1) # sort by line length to take the shortest result
    if [ ! -z "${workspace}" ]; then
      ${vscodeBinary} ${workspace}
      return 0
    fi
  fi
  ${vscodeBinary} ${folderToOpen}
}
