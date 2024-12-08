#!/bin/bash

# CSV File to store the results
output_file="mesa_products.csv"
echo "ProductNO,ProductTitle,ProductCode,Availability,Price,ImageURL,ManualURL,SupportSoftwareURL,SoftDMCManualURL" > "$output_file"

# Function to scrape product details
scrape_product() {
  product_no=$1
  url="http://store.mesanet.com/index.php?route=product/product&product_id=$product_no"

  # Get the page content
  page_content=$(curl -s "$url")

  # Check if the product exists
  title=$(echo "$page_content" | grep -oP '(?<=<title>).*?(?=</title>)')
  if [[ "$title" == "Product not found!" ]]; then
    echo "Product $product_no not found. Skipping..."
    return
  fi

  # Extract details
  product_code=$(echo "$page_content" | grep -oP '(?<=<li>Product Code: ).*?(?=</li>)')
  availability=$(echo "$page_content" | grep -oP '(?<=<li>Availability: ).*?(?=</li>)')
  price=$(echo "$page_content" | grep -oP '(?<=<h2>US\$).*?(?=</h2>)')
  image_url=$(echo "$page_content" | grep -oP 'http://store.mesanet.com/image/cache/catalog/.*?500x500\.png')

  # Extract manuals and software links
  manual_url=$(echo "$page_content" | grep -oP '(?<=<td><a href=").*?(?=">Download Support Manual</a>)')
  support_software_url=$(echo "$page_content" | grep -oP '(?<=<td><a href=").*?(?=">Download Support Software</a>)')
  softdmc_manual_url=$(echo "$page_content" | grep -oP '(?<=<td><a href=").*?(?=">Download SoftDMC Manual</a>)')

  # Write details to CSV
  echo "$product_no,\"$title\",$product_code,$availability,US\$$price,$image_url,$manual_url,$support_software_url,$softdmc_manual_url" >> "$output_file"
}

# Iterate over product IDs
for product_id in {1..500}; do
  echo "Processing Product ID: $product_id"
  scrape_product "$product_id"
  sleep 5  # Delay for 5 seconds
done


echo "Scraping completed. Results saved in $output_file."

