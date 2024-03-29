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

# helper func to move files to student folders
move_student_files() {
    student_name="$1"
    mkdir -p "$student_name"  # create new folder for the student if it doesn't exist
    mv "$2" "$student_name"  # move file into the student's folder
}

# for any file in the current directory (depth 1):
find . -maxdepth 1 -type f | while IFS= read -r file; do
    # get student name from the file name (read until first '_' & remove './' from the beginning of the file name)
    folder_name=$(echo "$file" | cut -d'_' -f1 | sed 's|./||')
    # helper func to move file to student folder
    move_student_files "$folder_name" "$file"
    echo "Moved $file to $folder_name folder."
done