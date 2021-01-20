#!/bin/bash

# Make sure a host entry (in /etc/hosts) is set to the given ip address.
# This will fail with an error if there already is an entry for that host with a different ip.
# @param1 ip adress
# @param2 hostname

setHostEntry() {
  if [ -z "${1}" ]; then
    logError "Please provide an ip address as the first argument."
    return 1
  fi
  if [ -z "${2}" ]; then
    logError "Please provide the host name as the second argument."
    return 1
  fi
  local ip=${1}
  local host=${2}
  local hostsFile=/etc/hosts
  # There already is a matching host entry. Check if ips match!
  if grep -i "${host}" "${hostsFile}" > /dev/null ; then
    local existingIpAddress=`grep -i "${host}" "${hostsFile}" | perl -p -e "s/^([0-9.]+).*/\\$1/"`
    if [ "${existingIpAddress}" = "${ip}" ]; then
      logSuccess "Entry in ${hostsFile} already set."
      return 0
    else 
      logError "Found an entry for ${host} in ${hostsFile}, but ip was not ${ip} as expected. Please investigate."
      return 1
    fi
  fi
  logInfo "Going to need root access to set hosts entry. Trying with sudo …"
  sudo bash -c "printf '\n${ip}  ${host}\n\n' >> ${hostsFile}"
  logSuccess "Entry in ${hostsFile} set."
}
