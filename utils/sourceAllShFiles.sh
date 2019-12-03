###
#	This function will source all .sh files in the given directory and its subdirectories.
###
function sourceAllShFiles() {
  if [ -z "${1}" ]; then
    echo "Please provide a path to sourceAllShFiles." > /dev/stderr
    return 1
  fi
  if [ ! -d "${1}" ]; then
    echo "The given argument '${1}' does not appear to be a directory." > /dev/stderr
    return 1
  fi
	for file in ${1}/**/*.sh; do
		source $file
	done
	for file in ${1}/*.sh; do
		source $file
	done
}