#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Missing FILE parameter"
    echo "Usage: $0 FILE_TO_COMPRESS"
    return 1
fi

filename="$1"

tar cfJ "$filename.tar.xz" "$filename"
if [ $? -ne 0 ]; then
    echo "Error: tar command failed"
else
    rm $filename
fi