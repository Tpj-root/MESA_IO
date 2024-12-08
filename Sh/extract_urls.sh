#!/bin/bash

# Input CSV file
input_file="mesa_products.csv"

# Extract PNG URLs
echo "PNG URLs:"
grep -o 'http[^,]*\.png' "$input_file"

# Extract PDF URLs
echo -e "\nPDF URLs:"
grep -o 'http[^,]*\.pdf' "$input_file"

# Extract ZIP URLs
echo -e "\nZIP URLs:"
grep -o 'http[^,]*\.zip' "$input_file"

