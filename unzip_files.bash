#!/bin/bash

# Author Natalie Chmura
# Description: BASIC SCRIPT FOR MASS UNZIPPING LAB FILES
# If you have any ideas/ critiques please let me know this was just something I threw together to automate the process

IFS='_' # String deliminator since Canvas tends to do lastnamefirstname_submissiondataetcetc.zip, this just grabs the lastnamefirstname 

for z in *.zip; do
	str="${z%.zip}"
	read -r target extra <<< "$str" 
	mkdir "$target"
	unzip "$z" -d "$target"
	rm -rf "$z" # Comment this out if you don't want the auto zip removal
done
