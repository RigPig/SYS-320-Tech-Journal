#!/bin/bash

# Define file paths
input_file="report.txt"
output_file="/var/www/html/report.html"

# Create HTML table header
echo "<html><body><table border='1' cellspacing='0' cellpadding='5'>" > "$output_file"

# Convert each line from input file to HTML row
while IFS= read -r line; do
    echo "<tr><td>$line</td></tr>" >> "$output_file"
done < "$input_file"

# Close HTML table and body
echo "</table></body></html>" >> "$output_file"

#successful conversion message
echo "HTML report generated successfully at $output_file"
