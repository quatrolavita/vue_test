#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

filePath="$1"

if [ -f "$filePath" ]; then
    rm "$filePath"
    echo "File '$filePath' deleted successfully."
else
    echo "File '$filePath' does not exist."
fi
