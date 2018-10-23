#!/bin/bash

###
#
# Create a directory and cd into it.
# @param $1 – the directory to be created
#
###
function makeDirectoryAndGoThere() {
	mkdir $1 && cd $_
}
