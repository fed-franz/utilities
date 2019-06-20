#!/bin/bash

function check_exit () {
    # "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        echo "ERROR: $1 failed ($status)" >&2
        exit $status
    fi
}