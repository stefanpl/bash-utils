#!/bin/bash
set -e

if [ -z "$BASH_SOURCE[0]" ]; then
  scriptDir=`dirname "$(readlink -f "$0")"`
else
  scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
fi

if [ -z "$BASH_UTILS_LOCATION"  ]; then
  echo "No value found for BASH_UTILS_LOCATION. Please set it in your environment." > /dev/stderr
  exit 1
fi

# Source all files in the utils folder and its subfolders
source ${BASH_UTILS_LOCATION}/utils/sourceAllShFiles.sh
sourceAllShFiles ${BASH_UTILS_LOCATION}/utils
