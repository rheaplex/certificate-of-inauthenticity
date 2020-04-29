#!/bin/bash

source ./config.sh


if [ -f "${METADATA_DIR_HASH_FILE}" ]; then
    echo "ipfs-metadata-dir-hash file already exists, not adding files to ipfs."
    exit 1
fi

# Deploy the image files

ipfs add -Q -w "${METADATA_DIR}/"* > "${METADATA_DIR_HASH_FILE}"
