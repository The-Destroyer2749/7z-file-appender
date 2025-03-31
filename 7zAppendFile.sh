#!/bin/bash

# error handling for incorrect number of script parameters
if [ "$#" -lt 2 ]; then
	echo "Not enough arguments passed" >&2
	exit 1
fi

# input refrence sheet:
# 1: original .7z file path
# 2: file / folder to add to the new .7z
# 3: directory to do all the unzipping and actual work in
# 4: password for the .7z so the user doesn't have to be prompted for it

if [ ! -d "$3" ]; then
	echo "The working directory provided does not exist" >&2
	read -p "Would you like to create it? y/n" response
	response=${response,,} # makes the text lowercase
	if [[ "$response"  =~ ^(yes|y)$ ]]; then
		mkdir "$3"
	fi
fi
name=$(basename "$1")
mv "$1" "$3"
cd "$3"
7z e "$name" -p"$4"
# rm "$name"
mv "$2" "$3"
7z a "$name" -r * -p"$4"
