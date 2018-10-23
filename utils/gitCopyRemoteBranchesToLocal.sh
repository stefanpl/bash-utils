#!/bin/bash

# Creates local branches for all remote branches and sets up tracking

function gitCopyRemoteBranchesToLocal() {
  git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
  git fetch --all
  git pull --all  
}
