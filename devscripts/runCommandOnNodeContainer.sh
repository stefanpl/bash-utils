#!/bin/bash
set -e

scriptDirectory=$( dirname ${BASH_SOURCE[0]} )
source ${scriptDirectory}/utils.sh

runCommandOnNodeContainer ${*}