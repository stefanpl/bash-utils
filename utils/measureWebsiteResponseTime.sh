#!/bin/bash

#
# Retrieves a webpage and prints out the time needed.
#
function measureWebsiteResponseTime {
  if [ -z "${1}" ]; then
    logError "Provide a url as the first parameter!"
    return 1
  fi
  curl -o /dev/null \
     -H 'Cache-Control: no-cache' \
     -s \
     -w "Connect: %{time_connect}s \nTTFB: %{time_starttransfer}s \nTotal time: %{time_total}s \n" \
     ${1}
}