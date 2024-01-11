#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Please specify a directory as an argument!"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "$1 is not a directory!"
    read -p "Enter a directory: " dir
    if [ ! -d "$dir" ]; then
        echo "$dir is not a directory!"
        exit 1
    fi
    cd "$dir"
fi


# Loop through all files in the directory and count them.
# This includes files in subdirectories.
totalFiles=$(ls -l $1 | sed 1d | wc -l | tr -s ' ' | awk '{print $1}')
echo "The total number of files is: $totalFiles"
# Count only the number of regular files in the directory
numRegularFiles=$(ls -l "$1" | grep "^-" | grep -v "/\." | grep -v "/$" | wc -l | awk '{print $1}')
echo "The total number of regular files is: $numRegularFiles"

# Count the number of directories in the directory
numDirectories=$(ls -lR "$1" | grep "^d" | grep -v "/\." | wc -l | awk '{print $1}')
echo "The total number of directories is: $numDirectories"

# Count the number of symbolic links in the directory
numLinks=$(ls -lR "$1" | grep "^l" | grep -v "/\." | wc -l | awk '{print $1}')
echo "The total number of symbolic links is: $numLinks"

# Find the largest file in bytes
largestFile=$(ls -lR "$1" | grep "^-" | grep -v "/\." | awk '{print $5, $NF}' | sort -nr | head -1 | awk '{print $1}')
echo "The largest file is: $largestFile bytes"

# Find the smallest file in bytes
smallestFile=$(ls -l $1 | sed 1d | awk '{print $5, $NF}' | sort -n | head -1 | awk '{print $1}')
echo "The smallest file is: $smallestFile bytes"
# Find how many bytes the local files use
totalBytes=$(ls -l $1 | sed 1d | awk '{print $5}' | tr -s ' ' | awk '{sum+=$1} END {print sum}')
echo "The local files use: $totalBytes bytes"