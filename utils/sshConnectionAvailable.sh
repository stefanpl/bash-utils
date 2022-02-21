###
# Check if a remote ssh can be reached
#  by checking if an "echo huhu" can be successfully executed.
#
# @param1 ssh connection string
# @example sshAvailable mySshAlias
# @example sshAvailable panepeter@zauberbude.com
###
sshConnectionAvailable() {
  ssh -o ConnectTimeout=1 -o ConnectionAttempts=1 "${1}" "echo huhu" > /dev/null 2>&1
  return $?
}