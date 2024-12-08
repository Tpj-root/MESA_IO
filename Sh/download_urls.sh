#!/bin/bash

# Input file containing URLs
input_file="urls.txt"

# Directory to save downloaded files
output_dir="downloads"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Read each URL from the input file and download using wget
while IFS= read -r url; do
    # Skip empty lines
    if [ -n "$url" ]; then
        # Download the file and save it in the output directory
        echo "Downloading $url..."
        wget -P "$output_dir" "$url"
    fi
done < "$input_file"

echo "Download complete!"

