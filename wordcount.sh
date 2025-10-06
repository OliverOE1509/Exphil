#!/bin/bash
# Usage: ./wordcount.sh mydocument.tex

if [ -z "$1" ]; then
    echo "Usage: $0 filename.tex"
    exit 1
fi

# Run texcount and display word count summary
texcount -1 -sum "$1"

