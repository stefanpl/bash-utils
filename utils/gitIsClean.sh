#!/bin/bash
###
# Checks if the git repo is clean, e.g. has no changes
# @param1: string to compare current git branch to
###
function gitIsClean() {
  [[ -z $(git status --porcelain) ]]
  return
}
