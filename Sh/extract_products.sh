#!/bin/bash
# bash extract_products.sh
# Enter the product numbers (comma-separated, e.g., 52,54): 141,142,144,145,146,147,149,233,310
#
# sorted list in ascending order
# echo "141,142,310,233,145,144,147,146,149" | tr ',' '\n' | sort -n | tr '\n' ',' | sed 's/,$//'
# Input file containing the product list
input_file="product_list.txt"

# Prompt for product numbers
read -p "Enter the product numbers (comma-separated, e.g., 52,54): " product_numbers

# Convert the input into an array
IFS=',' read -r -a product_array <<< "$product_numbers"

# Loop through each product number and extract the corresponding line
echo "ProductNO|ProductCode|Availability|Price US$|"
for product_no in "${product_array[@]}"; do
    # Use grep to find the line starting with the product number
    grep -E "^\[$product_no\]" "$input_file"
done

