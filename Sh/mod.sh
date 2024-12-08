#!/bin/bash

input_file="edit"
output_file="outputfile.txt"

# Clear or create the output file
> "$output_file"

# Read each line from the input file
while IFS= read -r line; do
    # Extract the ID (first field before '|')
    id=$(echo "$line" | cut -d'|' -f1)
    # Create the modified line
    modified_line="[${id}](http://store.mesanet.com/index.php?route=product/product&product_id=${id})|${line#*|}"
    # Append the modified line to the output file
    echo "$modified_line" >> "$output_file"
done < "$input_file"

echo "Transformation complete. Modified lines are saved in '$output_file'."

