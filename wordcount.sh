#!/bin/bash
# Usage: ./wordcount.sh mydocument.tex "Introduction" "Discussion"

if [ $# -lt 2 ]; then
    echo "Usage: $0 filename.tex \"Section1\" [\"Section2\" ...]"
    exit 1
fi

filename="$1"
shift
sections=("$@")

for section in "${sections[@]}"; do
    echo "Counting words in section: $section"
    # Extract the text between \section{SectionName} and the next \section{...}
    awk -v section="$section" '
        $0 ~ "\\section\\{" section "\\}" {found=1; next}
        found && $0 ~ /^\\section\{/ {found=0}
        found
    ' "$filename" > /tmp/section_extract.tex
	
    # Count words in extracted section
    count=$(texcount -1 -sum /tmp/section_extract.tex)
    echo " Words: $count"
    total=$((total + count))
done
echo "----------------------------------------------------"
echo "Total words across selected sections: $total"
