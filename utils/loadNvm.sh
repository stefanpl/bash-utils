#!/bin/bash

# Without sourcing the nvm script, there is no "node" available at the command line

function loadNvm() {
	if ! [ -x "$(command -v npm)"  ]; then
		if [ -z "$NVM_DIR" ]; then
    		logError "\$NVM_DIR is not set. Cannot load nvm."
				return 1
		fi
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
		[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	fi
}

