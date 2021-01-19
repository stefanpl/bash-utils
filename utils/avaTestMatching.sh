#!/bin/bash

# Searches for variables in a file declared as:
# variable=value
# and exports them so they can be used by child scripts.

avaTestMatching() {
  if [ -z "${1}" ]; then
    nx ava
  else
    nx ava --match "$1*"
  fi
}
