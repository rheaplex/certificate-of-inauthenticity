#!/bin/bash

if [ -f ipfs-image-dir-hash ]; then
    echo "ipfs-image-dir-hash file already exists, not adding files to ipfs."
    exit 1
fi

# tee to stderr so we can see the result in case of error

ipfs add -w metadata/images/*.png | \
    tee /dev/fd/2 | \
    awk '/added ([^ ]+)$/ {print $2}' | \
    > ipfs-image-dir-hash
