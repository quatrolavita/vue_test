#!/bin/bash

# Check if the PATH is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <path>"
    exit 1
fi

path="$1"
output_file="output.js"

# Function to recursively process the files and folders
process_item() {
    local item="$1"
    local relative_path="${item#$path}" # Calculate the relative path
    
    if [ -d "$item" ]; then
        # Directory
        local type="folder"
        local folder_name="'$(basename "$item")'"
        local md_name_list="["
        local md_file_name="null"
        
        for file in "$item"/*.md; do
            md_name=$(basename "$file" .md) # Remove .md extension
            md_name_list="${md_name_list} '$md_name',"
        done
        
        md_name_list="${md_name_list%,}]"
        
        for dir in "$item"/*/; do
            process_item "$dir"
        done
    elif [ -f "$item" ]; then
        # File
        local type="mdFile"
        local folder_name="null"
        local md_name_list="null"
        local md_file_name="'$(basename "$item")'"
    else
        return
    fi
    
    echo "{type: '$type', folderName: $folder_name, mdNameList: $md_name_list, mdFileName: $md_file_name, filePath: '$relative_path'}," >> "$output_file"
}

# Clear the output file if it exists and write the initial export statement
echo "export const sidebarItems = [" > "$output_file"

# Process the specified path
process_item "$path"

# Add the final closing bracket
echo "];" >> "$output_file"

echo "Export statement written to $output_file"
