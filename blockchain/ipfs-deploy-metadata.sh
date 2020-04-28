#!/bin/bash

METADATA_DIR_HASH_FILE="ipfs-metadata-dir-hash"
METADATA_SRC_DIR="./metadata/json/"

if [ -f "${METADATA_DIR_HASH_FILE}" ]; then
    echo "ipfs-metadata-dir-hash file already exists, not adding files to ipfs."
    exit 1
fi

# Deploy the image files

ipfs add -Q -w "${METADATA_SRC_DIR}/"*.json > "${METADATA_DIR_HASH_FILE}"
