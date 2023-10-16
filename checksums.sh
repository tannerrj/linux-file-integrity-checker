#!/bin/bash

# Specify the directory you want to run checksums on - no trailing slash at the end of the directory path or else it will mess up with the summary info
directory="/path/to/your/directory"

# Create checksum files
md5sum "$directory"/* > md5sum.txt
sha1sum "$directory"/* > sha1sum.txt
sha256sum "$directory"/* > sha256sum.txt
sha512sum "$directory"/* > sha512sum.txt

# Create an ordered list HTML file
html_file="checksums.html"
echo "<html><body><head><title>Checksum Report</title></head><h1>Checksums</h1><ul>" > "$html_file"

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