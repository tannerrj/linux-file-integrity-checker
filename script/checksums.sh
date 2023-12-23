#!/bin/bash

# Script: checksum.sh
# Author: Rick Tanner via ChatGPT
# Description: This script that will run a md5, sha1sum, sha256sum, sha512sum on all files in a specified directory and then create a md5 sum file, sha1sum file, sha256sum file, sha512sum file and then creates an ordered list html file sorted alphabetically by file name.
# Project URL: https://github.com/tannerrj/linux-file-integrity-checker
# License: MIT License


# Step 1: Specify the directory you want to run checksums on - no trailing slash at the end of the directory path or else it will mess up the summary info.
directory="/path/to/your/directory"

# Step 2: Script creates the checksum files.
# MD5, SHA1, SHA256, and SHA512 checksums are calculated for all files in the specified directory.
# Checksums are saved into separate files: md5sum.txt, sha1sum.txt, sha256sum.txt, and sha512sum.txt.
md5sum "$directory"/* > md5sum.txt
sha1sum "$directory"/* > sha1sum.txt
sha256sum "$directory"/* > sha256sum.txt
sha512sum "$directory"/* > sha512sum.txt

# Create an ordered list HTML file
html_file="checksums.html"
echo "<!DOCTYPE html><html lang=\"en\"><head><title>Checksum Report</title></head><h1>Checksums</h1><ul>" > "$html_file"

# Generate checksum list and sort alphabetically by filename
for file in "$directory"/*; do
    filename=$(basename "$file")
    echo "<li>$filename:<ul>" >> "$html_file"
    echo "<li>MD5: $(md5sum "$file" | awk '{print $1}')</li>" >> "$html_file"
    echo "<li>SHA1: $(sha1sum "$file" | awk '{print $1}')</li>" >> "$html_file"
    echo "<li>SHA256: $(sha256sum "$file" | awk '{print $1}')</li>" >> "$html_file"
    echo "<li>SHA512: $(sha512sum "$file" | awk '{print $1}')</li>" >> "$html_file"
    echo "</ul>" >> "$html_file"
done

echo "</ul></body></html>" >> "$html_file"

echo "Checksums and HTML report generated successfully.