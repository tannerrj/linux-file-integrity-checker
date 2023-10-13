# Introduction

Linux Disk Space Tracker

## Inquiry

User
```
Show me bash script that will run a md5, sha1sum, sha256sum, sha512sum on all files in a specified directory and create a md5 sum file, sha1sum file, sha256sumfile , sha512sum file and then create an ordered list html file sorted alphabetically by file name
```

### Results

Certainly! Below is a Bash script that accomplishes the tasks you described:

```bash
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
echo "<html><body><h1>Checksums</h1><ul>" > "$html_file"

# Generate checksum list and sort alphabetically by filename
for file in "$directory"/*; do
    filename=$(basename "$file")
    echo "<li>$filename:</li><ul>" >> "$html_file"
    echo "<li>MD5: $(md5sum "$file" | awk '{print $1}')</li>" >> "$html_file"
    echo "<li>SHA1: $(sha1sum "$file" | awk '{print $1}')</li>" >> "$html_file"
    echo "<li>SHA256: $(sha256sum "$file" | awk '{print $1}')</li>" >> "$html_file"
    echo "<li>SHA512: $(sha512sum "$file" | awk '{print $1}')</li>" >> "$html_file"
    echo "</ul>" >> "$html_file"
done

echo "</ul></body></html>" >> "$html_file"

echo "Checksums and HTML report generated successfully."
```

Make sure to replace `/path/to/your/directory` with the actual path to the directory where you want to calculate the checksums. When you run this script, it will create the following files:

1. `md5sum.txt`: Contains MD5 checksums for all files in the specified directory.
2. `sha1sum.txt`: Contains SHA-1 checksums for all files in the specified directory.
3. `sha256sum.txt`: Contains SHA-256 checksums for all files in the specified directory.
4. `sha512sum.txt`: Contains SHA-512 checksums for all files in the specified directory.
5. `checksums.html`: An HTML report that lists the files and their corresponding checksums sorted alphabetically by filename.

You can run the script by saving it to a file (e.g., `checksums.sh`), making it executable with `chmod +x checksums.sh`, and then running `./checksums.sh`.