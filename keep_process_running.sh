#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Error: Missing CMD parameter"
    echo "Usage: $0 COMMAND_TO_EXECUTE"
    return 1
fi

psname="$1"

while true; do
    echo "Running $psname"
	$psname
done